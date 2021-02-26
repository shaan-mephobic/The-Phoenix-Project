package com.Phoenix.project
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.content.Context
import android.content.ContextWrapper
import android.content.ContentUris;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.os.Environment;
import java.net.URI
import java.nio.file.Path
import android.content.ContentProvider
import androidx.core.content.FileProvider
import android.content.ContentValues;
import android.content.Intent
import android.util.Log
import android.media.MediaScannerConnection
import java.util.Objects
import java.nio.file.Paths
import java.io.File
import android.provider.DocumentsContract;
import android.content.pm.ResolveInfo
import java.lang.Package
import java.lang.StringBuilder
import androidx.core.content.ContextCompat
import android.content.IntentFilter
import java.io.FileInputStream
import android.Manifest
import android.widget.Toast
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity



class MainActivity: FlutterActivity() {
    var float:Any? = "";
    var globuri:Any?="";
    var young:File?=File("");
    var summa=Uri.parse("pain")
    var callleach:Uri=summa;

    
    private val CHANNEL = "com.Phoenix.project/kotlin";
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
          call, result -> 

          if(call.method =="Setty"){
                        val arguments = call.arguments<Map<String, Any>>()
          var val1 = arguments["val1"]
          println("right after this")
          println(val1)
          float = val1
          shareOneAudio();
dickfuck();


        //  var val1 = arguments["val1"]
         
        // File ring = new File(val1);
        // Uri path = MediaStore.Audio.Media.getContentUriForPath(ring.getAbsolutePath());
        // RingtoneManager.setActualDefaultRingtoneUri(getApplicationContext(), RingtoneManager.TYPE_RINGTONE,path);

    }
    else if(call.method =="Gandhi"){
gettingperm();
    }
    println("yes ")



    

        result.success("hoooom")
    }}
fun gettingperm(){

    //     if (!android.provider.Settings.System.canWrite(getApplicationContext())) {
    //         var intent:Intent = Intent(android.provider.Settings.ACTION_MANAGE_WRITE_SETTINGS, Uri.parse("package:" + getPackageName()));
    //         startActivityForResult(intent, 200);

    
    // }
 
        if(android.provider.Settings.System.canWrite(context)){
            println("its true")
            return }
            
        else{ 
            openAndroidPermissionsMenu();
    
    return }
    
}



fun openAndroidPermissionsMenu(){

        var intent:Intent = Intent(android.provider.Settings.ACTION_MANAGE_WRITE_SETTINGS);
        intent.setData(Uri.parse("package:" + context.getPackageName()));
        context.startActivity(intent);
    
}
fun shareOneAudio() {

    var poth = context.filesDir.absolutePath
    println(poth)
    // val filers = File("$poth/files/phoenixringtone")
     val authorities = "com.Phoenix.project.provider"
     var dried = File(getExternalFilesDir(null),"/phoenixringtone.$float")
     

     Log.i("com.Phoenix.project", Uri.fromFile(dried).toString());
     var ghost = Uri.fromFile(dried)
    //  MediaScannerConnection.scanFile(this,dried.getAbsolutePath() , null,
    //          (path, uri) -> Log.i(TAG, uri.toString()));

     println("thisboink")
    println(dried)

    // var poolth = MediaStore.Audio.Media.getContentUri(dried.path);
    println("lawofall")
    // println(poolth)
    // var lemmefile:File = File("/storage/emulated/0/Android/data/com.Phoenix.project/files/phoenixringtone.$float")
    // var lemmefile = dried
    var lemmefile:File=File(getExternalFilesDir(null),"/phoenixringtone.$float")
     var firstAudio: File = lemmefile
     young = firstAudio
    var luvme = FileProvider.getUriForFile(this, authorities, firstAudio)
    globuri =luvme
    // callleach=luvme
    callleach=ghost

// println("here shall exist")
// println(luvme)
// context.grantUriPermission("com.Phoenix.project", callleach, Intent.FLAG_GRANT_READ_URI_PERMISSION);

//     activity.grantUriPermission("com.Phoenix.project", callleach,Intent.FLAG_GRANT_WRITE_URI_PERMISSION);

//     val shareIntent = Intent()
//     shareIntent.addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
//     shareIntent.action = Intent.ACTION_SEND
//     shareIntent.addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION)
//     shareIntent.putExtra(Intent.EXTRA_STREAM, luvme)
//     shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
//     shareIntent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
//     shareIntent.type = "audio/*"
//     startActivity(Intent.createChooser(shareIntent, "Share..."))
 
    // var tracker = File(getExternalFilesDir(null),"/phoenixringtone.$float")
    // var track = tracker
    // println("corridor")
    // println(track)
    // var values:ContentValues = ContentValues();
    // values.put(MediaStore.MediaColumns.DATA, track!!.getPath());
    // values.put(MediaStore.MediaColumns.TITLE, "phoenixringtone");
    // //values.put(MediaStore.MediaColumns.SIZE, 1024*1024);
    // values.put(MediaStore.MediaColumns.MIME_TYPE, "audio/*");
    // values.put(MediaStore.Audio.Media.ARTIST, "phoenix");
    // //values.put(MediaStore.Audio.Media.DURATION, 5000);
    // values.put(MediaStore.Audio.Media.IS_RINGTONE, true);
    // values.put(MediaStore.Audio.Media.IS_NOTIFICATION, false);
    // values.put(MediaStore.Audio.Media.IS_ALARM, false);
    // values.put(MediaStore.Audio.Media.IS_MUSIC, true);
    // var uri = MediaStore.Audio.Media.getContentUriForPath(track.getPath());
    // if (uri == null || context.getContentResolver() == null) {
    //   Toast.makeText(context, context.getString(69), Toast.LENGTH_SHORT).show();
    //   return;
    // }
    // //TODO check this may be better copy file in ringtone dir before?

    // context.getContentResolver().delete(uri, MediaStore.MediaColumns.DATA + "=\"" + track.getPath() + "\"", null);
    // var newUri = context.getContentResolver().insert(uri, values);
    // println("youth")
    // if (newUri == null) {
    //   Toast.makeText(context, context.getString(6969), Toast.LENGTH_SHORT).show();
    // } else {
    //     println("alabamaa")
    //   RingtoneManager.setActualDefaultRingtoneUri(context, RingtoneManager.TYPE_RINGTONE, newUri);
    //   println("bama")
    //   Toast.makeText(context, context.getString(696969), Toast.LENGTH_SHORT).show();
    // }
    
}
       
     fun dickfuck(){





//             println("is it?")    

//             var Stringger:String = float as String
// var wolf:String
// var wolfer:Uri=Uri.parse("")
//         // Uri.fromFile(new File("/sdcard/sample.jpg"))
//         if(Stringger=="mp3"){
//             wolf="content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2Fphoenixringtone.mp3"
//             wolfer = Uri.parse(wolf)
//             println("CAUGHT THIS CAUGHT")
//         }
//         else if(Stringger=="wav"){
//             wolf="content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2Fphoenixringtone.wav"
//             wolfer = Uri.parse(wolf)
//             println("CAUGHT THIS CAUGHT")
//         }
//         else if(Stringger=="m4a"){
//             wolf="content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2Fphoenixringtone.m4a"
//             wolfer = Uri.parse(wolf)
//             println("CAUGHT THIS CAUGHT")
//         }
//         else if(Stringger=="flac"){
//             wolf="content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2Fphoenixringtone.flac"
//             wolfer = Uri.parse(wolf)
//             println("CAUGHT THIS CAUGHT")
//         }
//         else if(Stringger=="aac"){
//             wolf="content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2Fphoenixringtone.aac"
//             wolfer = Uri.parse(wolf)
//             println("CAUGHT THIS CAUGHT")
//         }
//         else{
//             println("NONE OF IT SATISFIED")
       
//         }



// println("here below");

// var blahblah= context.getApplicationInfo().dataDir+"/files/phoenixringtone.mp3"
// println("this this this this this")
// println(blahblah)
// var shoon=File(blahblah)
// var fallin = Uri.fromFile(shoon)
// println("thisistheoneglass")

// println(fallin)

// print(shoon)

// var somebodyhelpme=Uri.parse("content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2Fcom.Phoenix.project%2Ffiles%2FEden%20-%20Icarus.mp3")
// var anothe=somebodyhelpme.toString()
// var fucklife=Uri.parse(anothe)
// println("amiajoke")
// println(somebodyhelpme)
// var trialnerror=Uri.parse( "/data/user/0/com.Phoenix.project/files/Eden - Icarus.mp3")


println("checkcheck")
println(callleach)

var values: ContentValues =  ContentValues();
values.put(MediaStore.MediaColumns.DATA, young!!.getAbsolutePath());
values.put(MediaStore.MediaColumns.TITLE, "ring");
values.put(MediaStore.MediaColumns.MIME_TYPE, "audio/*");
values.put(MediaStore.MediaColumns.SIZE, young!!.length());
values.put(MediaStore.Audio.Media.ARTIST, "Phoenix");
values.put(MediaStore.Audio.Media.IS_RINGTONE, true);
values.put(MediaStore.Audio.Media.IS_NOTIFICATION, false);
values.put(MediaStore.Audio.Media.IS_ALARM, false);
values.put(MediaStore.Audio.Media.IS_MUSIC, false);


///////previous///////

    // RingtoneManager.setActualDefaultRingtoneUri(
    //     this, RingtoneManager.TYPE_ALL,
    //     callleach);
    // RingtoneManager.getDefaultUri(1)
    // RingtoneManager.getRingtone(context, callleach)

    try {
        if (android.provider.Settings.System.canWrite(getApplicationContext())){
             RingtoneManager.setActualDefaultRingtoneUri(context, RingtoneManager.TYPE_RINGTONE, callleach);
             Toast.makeText(context, " Ringtone has been changed", Toast.LENGTH_SHORT).show();
             }else {
                 Toast.makeText(context, "Allow modify system settings ==> ON ", Toast.LENGTH_LONG).show();
             }
         } catch (e:Exception) {
             Log.i("ringtone",e.toString());
             Toast.makeText(context, "Can't set as Ringtone  ", Toast.LENGTH_SHORT).show();
         }

    }}

