{{flutter_js}}
{{flutter_build_config}}

// Alles lokal: CanvasKit aus ./canvaskit/ (Build mit --no-web-resources-cdn)
// und Ersatzschriften aus ./fallback-fonts/ statt von Google-Servern.
// Fehlt dort eine Schrift, bleibt das Zeichen leer – es wird nie extern geladen.
const pkConfig = {
  canvasKitBaseUrl: 'canvaskit/',
  fontFallbackBaseUrl: 'fallback-fonts/',
};
_flutter.loader.load({
  config: pkConfig,
  onEntrypointLoaded: async function (engineInitializer) {
    // initializeEngine ersetzt die Konfiguration – daher alles erneut angeben.
    const appRunner = await engineInitializer.initializeEngine({
      ...pkConfig,
      hostElement: document.getElementById('app'),
    });
    await appRunner.runApp();
  },
});
