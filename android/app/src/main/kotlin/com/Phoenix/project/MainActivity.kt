package com.Phoenix.project

import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.hardware.camera2.CameraManager
import android.media.*
import android.media.audiofx.Visualizer
import android.net.Uri
import android.os.Environment
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import kotlin.concurrent.thread
import kotlin.math.abs
import com.ryanheise.audioservice.AudioServicePlugin


class MainActivity : FlutterActivity() {
    private val samplingRate = 44100
    private var visualizer: Visualizer? = null
    private var mWaveBuffer: ByteArray? = null
    private var mFftBuffer: ByteArray? = null
    private var mDataCaptureSize: Int = 0
    private var mAudioBufferSize: Int = 0
    private var mAudioRecord: AudioRecord? = null
    private var mAudioRecordState: Boolean = false
    private lateinit var cameraManager: CameraManager
    private lateinit var cameraID: String
    private var isVisualizing: Boolean = false
    private var torx: Boolean = false
    private var sensitivity: Double? = 50.0
    private var sinatra: MutableList<Double> = mutableListOf()
    private var onCompletingFlash: Boolean = false
    private val captureSizeRange = Visualizer.getCaptureSizeRange()
    private val channel = "com.Phoenix.project/kotlin"

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return AudioServicePlugin.getFlutterEngine(context)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "KotlinVisualizer" -> {
                    if (!isVisualizing) flashInit()
                    isVisualizing = true
                    result.success("nice")
                }
                "sensitivityKot" -> {
                    val arguments = call.arguments<Map<Any, Double?>>()
                    sensitivity = arguments["valueFromFlutter"]!!
                    result.success("nice")
                }
                "ResetKot" -> {
                    if (isVisualizing) resetKot()
                    isVisualizing = false
                    result.success("nice")
                }
                "deleteFile" -> {
                    val arguments = call.arguments<Map<Any, String?>>()
                    val pathToDelete: String = arguments["fileToDelete"]!!
                    deleteThis(pathToDelete)
                    result.success("nice")
                }
                "homescreen" -> {
                    setHomeScreenWallpaper()
                    result.success("nice")
                }
                "broadcastFileChange" -> {
                    val arguments = call.arguments<Map<Any, String?>>()
                    val pathToUpdate: String = arguments["filePath"]!!
                    broadcastFileUpdate(pathToUpdate)
                    result.success("nice")
                }
                "returnToOld" -> {
//                resetWallpaper();
                    result.success("nice")
                }
                "wallpaperSupport?" -> {
                    val wallpaperManager = WallpaperManager.getInstance(this)
                    val good: Boolean = wallpaperManager.isWallpaperSupported
                    val prettyGood = wallpaperManager.isSetWallpaperAllowed
                    if (good && prettyGood) goForWallpaper()
                    result.success("nice")
                }
                "setRingtone" -> {
                    val arguments = call.arguments<Map<Any, String?>>()
                    setRingtone(ringtonePath = arguments["path"]!!)
                    result.success("nice")
                }
                "checkSettingPermission" -> {
                    getSettingsPermission()
                    result.success("nice")
                }
                "externalStorage" -> {
                    result.success(getExternalStorageDirectories())
                }
            }
        }
    }

    private fun flashInit() {
        visualize()
        startVisualizing()
        cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        cameraID = cameraManager.cameraIdList[0]
    }

    private fun deleteThis(path: String) {
        File(path).delete()
        broadcastFileUpdate(path)
    }

    private fun broadcastFileUpdate(path: String) {
        context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(File(path))))
        println("updated!")
    }

    private fun resetKot() {
        switchVisualizing()
        println("reset complete")
        dontFlashDamnit()
        onCompletingFlash = true
    }

    private fun visualize() {
        mAudioBufferSize = AudioRecord.getMinBufferSize(samplingRate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_8BIT)
        mAudioRecord = AudioRecord(MediaRecorder.AudioSource.MIC, samplingRate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_8BIT, mAudioBufferSize)

        if (mAudioRecord!!.state != AudioRecord.STATE_INITIALIZED) println("AudioRecord init failed")
        else println("AudioRecord init success")

        try {
            visualizer = Visualizer(0).apply {
                enabled = false

                measurementMode = Visualizer.MEASUREMENT_MODE_PEAK_RMS

                captureSize = captureSizeRange[1]

                scalingMode = Visualizer.SCALING_MODE_NORMALIZED

                setDataCaptureListener(object : Visualizer.OnDataCaptureListener {
                    override fun onFftDataCapture(visualizer: Visualizer?, fft: ByteArray?, samplingRate: Int) {
                        if (!onCompletingFlash) updateVisualizerFFT(fft)
                    }

                    override fun onWaveFormDataCapture(visualizer: Visualizer?, waveform: ByteArray?, samplingRate: Int) {
                        if (!onCompletingFlash) {
                            updateVisualizer(waveform)
                        }
                    }


                }, Visualizer.getMaxCaptureRate(), true, true)
            }.apply {
                mDataCaptureSize = captureSize.apply {

                    mWaveBuffer = ByteArray(this)
                    mFftBuffer = ByteArray(this)
                }
            }
        } catch (e: Exception) {
            println("ERROR DURING VISUALIZER INITIALIZATION: $e")
        }
    }

    private fun updateVisualizer(bytes: ByteArray?) {
        var t = calculateRMSLevel(bytes)
        val measurementPeakRms = Visualizer.MeasurementPeakRms()
        var x: Int = visualizer!!.getMeasurementPeakRms(measurementPeakRms)
        var mBytes = bytes
    }

    private fun updateVisualizerFFT(bytes: ByteArray?) {
        var t = calculateRMSLevel(bytes)
        var mFFTBytes = bytes
    }

    private fun calculateRMSLevel(audioData: ByteArray?) {

        var amplitude = 0.0
        val loopSize: Int = audioData!!.size / 2
        for (i in 0 until loopSize) {
            val y: Double = (audioData[i * 2].toInt() or (audioData[i * 2 + 1].toInt() shl 8)) / 32768.0
            amplitude += abs(y)
        }
        amplitude = amplitude / audioData.size / 2
        if (onCompletingFlash) {
            dontFrickingFlashGoddamnit()
            println("using force")
        } else {
            if (sinatra.size != 5) {
                sinatra.add(amplitude)
            } else {
                var mean: Double = (sinatra[0] + sinatra[1] + sinatra[2] + sinatra[3] + sinatra[4]) / 5
                if (mean == 5.859375E-4) {
                    mean = 1.0
                }
                if (mean <= (sensitivity!! / 1000)) {
                    if (!torx) {
                        flashDamnit()
                    }
                } else {
                    dontFlashDamnit()
                }
                sinatra.removeAll(sinatra)
            }
        }
    }

    private fun switchVisualizing() {
        mAudioRecord!!.stop()
        visualizer?.enabled = false
        mAudioRecordState = false
    }

    private fun startVisualizing() {
        onCompletingFlash = false
        mAudioRecord!!.startRecording()
        visualizer?.enabled = true
        mAudioRecordState = true
    }

    private fun flashDamnit() {
        torx = true
        cameraManager.setTorchMode(cameraID, torx)
    }

    private fun dontFlashDamnit() {
        torx = false
        cameraManager.setTorchMode(cameraID, torx)

    }

    private fun dontFrickingFlashGoddamnit() {
        cameraManager.setTorchMode(cameraID, false)
    }


    private fun goForWallpaper() {
        thread {
            val wallpaperManager = WallpaperManager.getInstance(this)
            val saxyWallpaper = BitmapFactory.decodeFile("/storage/emulated/0/Android/data/com.Phoenix.project/files/legendary-er.png")
            wallpaperManager.setBitmap(saxyWallpaper, null, false, WallpaperManager.FLAG_LOCK)
        }
    }

    private fun setHomeScreenWallpaper() {
        thread {
            val wallpaperManager = WallpaperManager.getInstance(this)
            // yourWallpaper = BitmapFactory.decodeResource(context.getResources(),wallpaperManager.getDrawable())!!;
            // wallpaperManager.getDrawable()
            val saxyWallpaper = BitmapFactory.decodeFile("/storage/emulated/0/Android/data/com.Phoenix.project/files/legendary-er.png")
            wallpaperManager.setBitmap(saxyWallpaper, null, false, WallpaperManager.FLAG_SYSTEM)
        }
    }

    private fun getExternalStorageDirectories(): String? {
        val files = getExternalFilesDirs(null)
        for (file in files) {
            if (Environment.isExternalStorageRemovable(file)) {
                return file.path.replace("Android/data/com.Phoenix.project/files", "")
            }
        }
        return null
    }

    private fun getSettingsPermission() {
        if (!android.provider.Settings.System.canWrite(context)) {
            val intent = Intent(android.provider.Settings.ACTION_MANAGE_WRITE_SETTINGS)
            intent.data = Uri.parse("package:" + context.packageName)
            context.startActivity(intent)
        }
    }

    private fun setRingtone(ringtonePath: String) {
        if (android.provider.Settings.System.canWrite(context)) {
            try {
                RingtoneManager.setActualDefaultRingtoneUri(
                        context,
                        RingtoneManager.TYPE_RINGTONE,
                        Uri.fromFile(File(ringtonePath))
                )
            } catch (e: Exception) {
                Log.i("ringtone", e.toString())
                Toast.makeText(context, "Failed setting ringtone!", Toast.LENGTH_SHORT).show()
            }
        } else {
            getSettingsPermission()
        }
    }
}

