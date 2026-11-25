{{flutter_js}}
{{flutter_build_config}}

// Alles lokal: CanvasKit aus ./canvaskit/ (Build mit --no-web-resources-cdn)
// und Ersatzschriften aus ./fallback-fonts/ statt von Google-Servern.
// Fehlt dort eine Schrift, bleibt das Zeichen leer – es wird nie extern geladen.
_flutter.loader.load({
  config: {
    canvasKitBaseUrl: 'canvaskit/',
    fontFallbackBaseUrl: 'fallback-fonts/',
  },
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine({
      hostElement: document.getElementById('app'),
    });
    await appRunner.runApp();
  },
});
