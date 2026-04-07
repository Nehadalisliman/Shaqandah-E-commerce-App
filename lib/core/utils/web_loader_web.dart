// ignore: sorted_imports
import 'dart:ui_web' as ui_web; // المكتبة الصحيحة للويب في الإصدارات الحديثة
import 'dart:html' as html;

void registerWebImage(String viewType, String url) {
  // تسجيل الـ Factory الخاص بالويب بشكل مباشر وصريح
  // ignore: undefined_prefixed_name
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final element = html.ImageElement()
      ..src = url
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover';
    return element;
  });
}