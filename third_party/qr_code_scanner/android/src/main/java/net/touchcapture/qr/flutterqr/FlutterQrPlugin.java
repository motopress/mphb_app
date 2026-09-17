package net.touchcapture.qr.flutterqr;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * Java registration bridge for Flutter's generated plugin registrant.
 * The scanner implementation itself remains in Kotlin.
 */
public final class FlutterQrPlugin implements FlutterPlugin, ActivityAware {
    private static final String VIEW_TYPE_ID = "net.touchcapture.qr.flutterqr/qrview";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        binding.getPlatformViewRegistry().registerViewFactory(
                VIEW_TYPE_ID, new QRViewFactory(binding.getBinaryMessenger()));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        // No resources are owned directly by the registration bridge.
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        QrShared.INSTANCE.setActivity(binding.getActivity());
        QrShared.INSTANCE.setBinding(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        QrShared.INSTANCE.setActivity(null);
        QrShared.INSTANCE.setBinding(null);
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        QrShared.INSTANCE.setActivity(null);
        QrShared.INSTANCE.setBinding(null);
    }
}
