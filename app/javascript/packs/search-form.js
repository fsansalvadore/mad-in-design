const OpenSearchForm = () => {
    $('.search-close').hide();
    $('button.search-icon').on('click', function() {
        $(this).hide();
        $('body').toggleClass("open-search-form");
        $('.search-close').show();
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    $('.search-close').on('click', function() {
        $(this).hide();
        $('body').removeClass("open-search-form");
        $('button.search-icon').show();
    });
};

export { OpenSearchForm };
