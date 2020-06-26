const NiceSelectBox = () => {
    var nice_Select = $('select');
    if (nice_Select.length) {
        nice_Select.niceSelect();
    }
};

export { NiceSelectBox };
