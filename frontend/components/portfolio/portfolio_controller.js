import { Controller } from "stimulus";
import "./portfolio.css";

export default class extends Controller {
    connect() {
        require("imports-loader?$=jquery!jquery-plugin-viewport-checker/dist/jquery.viewportchecker.min");

        var items = $('#main_menu').find('.menu-item > a');
        items.each(function(){1
            if ($(this).attr('href').match('#') !== null)
                $(this).attr('href', "/" + $(this).attr('href'))
        });

        $(function () {
            $('.view-check').viewportChecker({
                offset: '30%'
            });
        });
    }
}