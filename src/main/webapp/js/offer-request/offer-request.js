function sliderInitialize() {
    $("#sale-slider-range").slider({
        range: true,
        min: 0,
        max: 19,
        step: 1,
        values: [2, 4],
        slide: function (event, ui) {
            $("#sale-amount").val((ui.values[0] + 1) + "억원 - " + (ui.values[1] + 1) + "억원");
        },
        create: function (event, ui) {
            setSliderTicks(event.target);
            $("#sale-amount").val(($("#sale-slider-range").slider("values", 0) + 1) + "억원 ~ " + ($("#sale-slider-range").slider("values", 1) + 1) + "억원");
        }
    });

    $("#deposit-slider-range").slider({
        range: true,
        min: 0,
        max: 100000,
        step: 1000,
        values: [2000, 10000],
        slide: function (event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setDepositSliderTicks(event.target);
            let priceFirst = $("#deposit-slider-range").slider("values", 0);
            let priceSecond = $("#deposit-slider-range").slider("values", 1);
            $("#deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        }
    });

    $("#monthly-deposit-slider-range").slider({
        range: true,
        min: 0,
        max: 5000,
        step: 50,
        values: [500, 1000],
        slide: function (event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#monthly-deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setMonthlyDepositSliderTicks(event.target);
            let priceFirst = $("#monthly-deposit-slider-range").slider("values", 0);
            let priceSecond = $("#monthly-deposit-slider-range").slider("values", 1);
            $("#monthly-deposit-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        }
    })

    $("#monthly-slider-range").slider({
        range: true,
        min: 0,
        max: 500,
        step: 5,
        values: [0, 40],
        slide: function (event, ui) {
            let priceFirst = ui.values[0];
            let priceSecond = ui.values[1];

            $("#monthly-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        },
        create: function (event, ui) {
            setMonthlySliderTicks(event.target);
            let priceFirst = $("#monthly-slider-range").slider("values", 0);
            let priceSecond = $("#monthly-slider-range").slider("values", 1);
            $("#monthly-amount").val(convertPriceToString(priceFirst) + " ~ " + convertPriceToString(priceSecond));
        }
    });
}

function setSliderTicks(el) {
    let $slider = $(el);
    let max = $slider.slider("option", "max");
    let min = $slider.slider("option", "min");
    let spacing = 100 / (max - min);

    $slider.find('.ui-slider-tick-mark').remove();
    for (let i = 0; i <= max - min; i++) {
        if ((i + 6) % 5 === 0 || i === 0) {
            $('<span class="ui-slider-tick-mark"><h5>' + (i + 1) + '억<h5></span>').css('left', (spacing * i) + '%').appendTo($slider);
        } else {
            $('<span class="ui-slider-tick-mark"></span>').css('left', (spacing * i) + '%').appendTo($slider);
        }
    }
}

function setDepositSliderTicks(el) {
    let $slider = $(el);
    let max = $slider.slider("option", "max");
    let min = $slider.slider("option", "min");
    let spacing = 100 / (max - min);

    $slider.find('.ui-slider-tick-mark').remove();
    for (let i = 0; i <= max - min; i += 10000) {
        $('<span class="ui-slider-tick-mark"><h5>' + convertPriceToString(i) + '<h5></span>').css('left', (spacing * i) + '%').appendTo($slider);
    }
}

function setMonthlyDepositSliderTicks(el) {
    let $slider = $(el);
    let max = $slider.slider("option", "max");
    let min = $slider.slider("option", "min");
    let spacing = 100 / (max - min);

    $slider.find('.ui-slider-tick-mark').remove();
    for (let i = 0; i <= max - min; i += 500) {
        $('<span class="ui-slider-tick-mark"><h5>' + convertPriceToString(i) + '<h5></span>').css('left', (spacing * i) + '%').appendTo($slider);
    }
}

function setMonthlySliderTicks(el) {
    let $slider = $(el);
    let max = $slider.slider("option", "max");
    let min = $slider.slider("option", "min");
    let spacing = 100 / (max - min);

    $slider.find('.ui-slider-tick-mark').remove();
    for (let i = 0; i <= max - min; i += 50) {
        $('<span class="ui-slider-tick-mark"><h5 class="thous">' + convertPriceToString(i) + '</h5></span>').css('left', (spacing * i) + '%').appendTo($slider);
    }
}

function convertPriceToString(price) {
    if (price === 0) {
        return price + "원";
    }

    if (price.toString().length <= 4) {
        return price + "만";
    } else {
        return (price / 10000).toString() + "억";
    }
}

function sliderTrigger(el) {
    let code = el.prev('input').val();

    if (code === "MONTHLY") {
        $("#monthlyPriceBox").show();
        $("#monthlyDepositBox").show();
        $("#depositBox").hide();
        $("#salePriceBox").hide();
    } else if (code === "SALE") {
        $("#salePriceBox").show();
        $("#depositBox").hide();
        $("#monthlyDepositBox").hide();
        $("#monthlyPriceBox").hide();
    } else {
        $("#depositBox").show();
        $("#salePriceBox").hide();
        $("#monthlyDepositBox").hide();
        $("#monthlyPriceBox").hide();
    }
}

function dialogInitialize() {
    $('#select-pyeong').on('click', function () {
        $('.overlay').toggle();
        $('#pyeong-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#select-room').on('click', function () {
        $('.overlay').toggle();
        $('#room-dialog').dialog({
            close: function (event, ui) {
                $('.overlay').toggle();
            }
        });
    });

    $('#pyeong-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#pyeong').val(val);
        $('#pyeong-txt').text(val);
        $('#pyeong-dialog').dialog('close');
    });

    $('#room-dialog > li').click(function (e) {
        let val = e.currentTarget.innerHTML;

        $('#room').val(val);
        $('#room-txt').text(val);
        $('#room-dialog').dialog('close');
    });
}

