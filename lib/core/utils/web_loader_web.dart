import 'dart:ui_web' as ui;
import 'dart:html' as html;

// نسخة الويب الحقيقية
Object createWebImage(String src) {
  return html.ImageElement()
    ..src = src
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.objectFit = 'cover';
}

// دالة تسجيل الصور الحقيقية للويب
void registerWebView(String viewId, String imageUrl) {
  ui.platformViewRegistry.registerViewFactory(
    viewId,
        (int viewId) => createWebImage(imageUrl),
  );
}