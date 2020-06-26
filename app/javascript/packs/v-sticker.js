const VStickerSnippet = () => {
  $('#datetime').vTicker({
      speed: 500,
      pause: 2000,
      animation: 'fade',
      mousePause: false,
      showItems: 1
  });
  $('#news-flash').vTicker({
      speed: 500,
      pause: 2000,
      animation: 'fade',
      mousePause: false,
      showItems: 1
  });
};

export { VStickerSnippet };
