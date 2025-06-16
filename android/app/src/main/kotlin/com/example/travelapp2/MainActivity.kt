package com.example.travelapp2

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/image_picker"
    private val REQUEST_CODE = 101
    private var imageFilePath: String? = null
    private var resultCallback: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "pickImage") {
                resultCallback = result
                val source = call.argument<String>("source")
                openImagePicker(source)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openImagePicker(source: String?) {
        val intent = when (source) {
            "camera" -> {
                val imageFile = File(cacheDir, "temp_image.jpg")
                imageFilePath = imageFile.absolutePath
                val imageUri: Uri = FileProvider.getUriForFile(this, "$packageName.provider", imageFile)
                Intent(MediaStore.ACTION_IMAGE_CAPTURE).apply { putExtra(MediaStore.EXTRA_OUTPUT, imageUri) }
            }
            "gallery" -> Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
            else -> null
        }

        intent?.let { startActivityForResult(it, REQUEST_CODE) }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            val imagePath = when {
                imageFilePath != null -> imageFilePath
                data?.data != null -> data.data?.let { getRealPathFromURI(it) }
                else -> null
            }

            resultCallback?.success(imagePath)
        }
    }

    private fun getRealPathFromURI(uri: Uri): String? {
        val cursor = contentResolver.query(uri, arrayOf(MediaStore.Images.Media.DATA), null, null, null)
        return cursor?.use {
            if (it.moveToFirst()) it.getString(it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)) else null
        }
    }
}
