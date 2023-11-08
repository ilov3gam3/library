<%@ page contentType="text/html;" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</section>
</section>

</div>



</div>
</div>


<footer id="footer" class="footer-1 ">
    <div id="footer-main" class="footer-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="logo-footer">
                        <a href="${pageContext.request.contextPath}/">
                            <img
                                    class="logo img-responsive"
                                    src="${pageContext.request.contextPath}/assets/logo-20-footer.png"
                                    alt="Molla - Prestashop eCommerce"
                                    style="width: 105px;"
                            />
                        </a>
                    </div>
                    <div class="widget html-1">
                        <p>Chúng tôi tự hào về việc cung cấp một môi trường thân thiện và dễ sử dụng cho bạn khám phá, nghiên cứu, và học hỏi. Thư viện của chúng tôi cung cấp sự truy cập dễ dàng đến kiến thức và thông tin cần thiết cho mọi người, từ học sinh, sinh viên, người yêu thích đọc sách đến các nhà nghiên cứu và chuyên gia trong các lĩnh vực khác nhau.</p>
                        <div class="widget-about-info">
                            <div class="row">
                                <div class="col-sm-6 col-md-4"><span class="widget-about-title">Bạn có thắc mắc? liên hệ chúng tôi 24/7</span>0327786417</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="footer-copyright" class="footer-copyright">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-7">
                    <p>Copyright © 2020 Molla Store. All Rights Reserved. <a class="cms-page-link" href="index.php?id_cms=3&controller=cms&id_lang=1">Terms Of Use</a> <a class="cms-page-link" href="index.php?id_cms=14&controller=cms&id_lang=1">Privacy Policy</a></p>
                </div>
                <div class="col-12 col-lg-5 text-lg-right">
                </div>
            </div>
        </div>
    </div>
</footer>
<button id="scroll-top" title="Back to top" class="show">
    <i class="icon-arrow-up"></i>
</button>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://prestashop17.joommasters.com/molla/themes/jms_molla/assets/cache/bottom-12ff6d38.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<script>
    const mess_error = "${error}"
    const mess_success = "${success}"
    const mess_warning = "${warning}"
    const info = "${info}"
    if (mess_error !== ""){
        toastr.error(mess_error, "Lỗi")
    }
    if (mess_success !== ""){
        toastr.success(mess_success, "Thành công")
    }
    if (mess_warning !== ""){
        toastr.warning(mess_warning, "Cảnh báo")
    }
    if (info !== ""){
        toastr.info(info, "Lưu ý")
    }
</script>
<script type="text/javascript">
    $(window).load(function(){
        $('.slider').each(function() {
            $(this).fractionSlider({
                'slideTransition' : $(this).attr('data-slideTransition'),
                'slideEndAnimation' : ($(this).attr('data-slideEndAnimation') == "1")?true:false,
                'transitionIn' : $(this).attr('data-transitionIn'),
                'transitionOut' : $(this).attr('data-transitionOut'),
                'fullWidth' : ($(this).attr('data-fullWidth') == "1")?true:false,
                'delay' : $(this).attr('data-delay'),
                'timeout' : $(this).attr('data-timeout'),
                'speedIn' : $(this).attr('data-speedIn'),
                'speedOut' : $(this).attr('data-speedOut'),
                'easeIn' : $(this).attr('data-easeIn'),
                'easeOut' : $(this).attr('data-easeOut'),
                'controls' : ($(this).attr('data-controls') == "1")?true:false,
                'pager' : ($(this).attr('data-pager') == "1")?true:false,
                'autoChange' : ($(this).attr('data-autoChange') == "1")?true:false,
                'pauseOnHover' : ($(this).attr('data-pauseOnHover') == "1")?true:false,
                'backgroundAnimation' : ($(this).attr('data-backgroundAnimation') == "1")?true:false,
                'backgroundEase' : $(this).attr('data-backgroundEase'),
                'responsive' : ($(this).attr('data-responsive') == "1")?true:false,
                'dimensions' : $(this).attr('data-dimensions'),
                'mobile_height' : $(this).attr('data-mobile_height'),
                'mobile2_height' : $(this).attr('data-mobile2_height'),
                'tablet_height' : $(this).attr('data-tablet_height'),
            })
        });
    });
</script>
<style type="text/css">
    #woorebought-popup {
        background-color: #ffffff;
        border-radius:0px;
    }
    #woorebought-popup p {
        color: #000000 !important;
        font-size:13px;
    }
    #woorebought-popup small {
        color:#000000 !important;
        font-size:11px !important;
    }
    #woorebought-popup a {
        color:#000000 !important;
        font-size:15px !important;
    }

</style>
<script type="text/javascript">
    'use strict';
    var woorebought = {
        use_ajax    : 0,
        loop        : 1,
        init_delay  : 3,
        total       : 10,
        display_time: 5,
        next_time   : 10,
        image       : 1,
        count       : 0,
        intel       : 0,
        id          : 0,
        popup_content    : '',
        products    : '',
        ajax_url    : '/molla/modules/gdz_recentlybought/ajax_gdz_recentlybought.php?_token=4640cd62608bc31d213d32a892c79f12',
        init        : function () {
            setTimeout(function () {
                woorebought.get_product();
            }, this.init_delay * 1000);

        },
        popup_show: function () {
            var count = this.count++;
            if (count == this.total-1) {
                return;
            }
            var popup_id = jQuery('#woorebought-popup'),
                popup_show_trans = jQuery('#woorebought-popup').data('show_trans'),
                popup_hide_trans = jQuery('#woorebought-popup').data('hide_trans');
            if (popup_id.hasClass(popup_hide_trans)) {
                jQuery(popup_id).removeClass(popup_hide_trans);
            }
            jQuery(popup_id).addClass(popup_show_trans).css('display', 'flex');
            setTimeout(function () {
                woorebought.popup_hide();
            }, this.display_time * 1000);
        },

        popup_hide: function () {
            var popup_id = jQuery('#woorebought-popup'),
                popup_show_trans = jQuery('#woorebought-popup').data('show_trans'),
                popup_hide_trans = jQuery('#woorebought-popup').data('hide_trans');

            if (popup_id.hasClass(popup_show_trans)) {
                jQuery(popup_id).removeClass(popup_show_trans);
            }
            jQuery('#woorebought-popup').addClass(popup_hide_trans);
            jQuery('#woorebought-popup').fadeOut((this.next_time>1)?1000:0);
            if (this.loop) {
                this.intel = setTimeout(function () {
                    woorebought.get_product();
                }, this.next_time * 1000);
            }
        },
        get_product : function () {
            if (this.use_ajax) {
                var str_data;
                if (this.id) {
                    str_data = '&id=' + this.id;
                } else {
                    str_data = '';
                }
                var wb = this;
                jQuery.ajax({
                    type   : 'POST',
                    data   : 'action=woorebought_show_product' + str_data,
                    url    : this.ajax_url,
                    success: function (respond) {
                        // console.log(respond);
                        wb.products = respond;
                    },
                    error  : function (respond) {
                    }
                })
            }
            // console.log(this);
            var products = this.products;
            var popup_content = this.popup_content;
            var image_redirect = this.image;
            products = jQuery.parseJSON(products);
            if (products.length > 0) {
                /*Get data*/
                var index = woorebought.random(0, products.length - 1);
                var product = products[index];
                var data_address = product.address;
                var data_product = product.title;
                var data_product_link = '<a target="_blank" href="' + product.product_link + '">' + product.title + '</a>';
                var data_time = '<small>About ' + product.time + ' ago</small>';
                var image_html = '';
                var img = $('<img src="' + product.image_link + '">');
                var image_html = $('<div>').append($(img).clone()).html();
                if (product.image_link && image_redirect) {
                    image_html = '<a target="_blank" href="' + product.product_link + '">' + image_html + '</a>';
                }
                /*Replace Content*/

                var replaceArray = ['{address}', '{product_name}', '{product_link}', '{time_ago}'];

                var replaceArrayValue = [data_address, data_product, data_product_link, data_time];
                var finalAns = popup_content;
                for (var i = replaceArray.length - 1; i >= 0; i--) {
                    finalAns = finalAns.replace(replaceArray[i], replaceArrayValue[i]);
                }
                var html = image_html + '<p>' + finalAns + '</p>';
                jQuery('.woorebought-content').html(html);
                // console.log('show');
                $(img).load(function(){
                    // console.log(image_html);
                    woorebought.popup_show();
                })

            }
        },
        close_notify: function () {
            jQuery('#popup-close').on('click', function () {
                woorebought.popup_hide();
            });
        },
        random      : function (min, max) {
            return Math.floor(Math.random() * (max - min + 1)) + min;
        }
    }

    jQuery(document).ready(function () {
        if (jQuery('#woorebought-popup').length > 0) {
            var data = jQuery('#woorebought-popup').data();
            var popup = woorebought;
            popup.products = '[{"title":"Butler Stool Ladder","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=20&rewrite=butler-stool-ladder&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/1\/0\/110.jpg","address":"New York City, New York, USA","time":"38 minutes"},{"title":"Octo 4240","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=21&id_product_attribute=40&rewrite=octo-4240&controller=product&id_lang=1#\/size-s\/color-black","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/1\/9\/119.jpg","address":"Alaska, USA","time":"21 minutes"},{"title":"Flow Slim Armchair","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=22&rewrite=flow-slim-armchair&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/2\/2\/122.jpg","address":"Alaska, USA","time":"A fews seconds"},{"title":"Roots Sofa Bed","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=23&id_product_attribute=52&rewrite=butler-stool-ladder&controller=product&id_lang=1#\/size-s\/color-black","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/2\/8\/128.jpg","address":"London, England","time":"26 minutes"},{"title":"Petite Table Lamp","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=24&id_product_attribute=65&rewrite=petite-table-lamp&controller=product&id_lang=1#\/color-brown\/size-xxl","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/3\/5\/135.jpg","address":"New York City, New York, USA","time":"16 minutes"},{"title":"Garden Armchair","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=25&rewrite=garden-armchair&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/4\/1\/141.jpg","address":"Paris, France","time":"4 minutes"},{"title":"Madra Log Holder","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=26&rewrite=madra-log-holder&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/4\/6\/146.jpg","address":"Paris, France","time":"16 minutes"},{"title":"Carronade Large Suspension Lamp","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=27&rewrite=carronade-large-suspension-lamp&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/4\/9\/149.jpg","address":"London, England","time":"20 minutes"},{"title":"Original Outdoor Beanbag","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=28&rewrite=original-outdoor-beanbag&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/5\/3\/153.jpg","address":"New York City, New York, USA","time":"14 minutes"},{"title":"2-Seater","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=29&rewrite=2-seater&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/5\/9\/159.jpg","address":"New York City, New York, USA","time":"41 minutes"},{"title":"Wingback Chair","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=30&rewrite=wingback-chair&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/6\/3\/163.jpg","address":"New York City, New York, USA","time":"41 minutes"},{"title":"Cushion Set 3 Pieces","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=31&rewrite=cushion-set-3-pieces&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/6\/7\/167.jpg","address":"New York City, New York, USA","time":"6 minutes"},{"title":"Carronade Table Lamp","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=32&rewrite=carronade-table-lamp&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/7\/2\/172.jpg","address":"London, England","time":"34 minutes"},{"title":"Cushion Set 3 Pieces","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=33&rewrite=cushion-set-3-pieces&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/7\/7\/177.jpg","address":"Alaska, USA","time":"33 minutes"},{"title":"Fritz Hansen Fritz Hansen Tray Table","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=34&id_product_attribute=128&rewrite=octo-4240&controller=product&id_lang=1#\/color-yellow","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/8\/1\/181.jpg","address":"New York City, New York, USA","time":"42 minutes"},{"title":"Santa Cole Cestita Bateria LED Akkuleuchte","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=35&rewrite=santa-cole-cestita-bateria-led-akkuleuchte&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/8\/4\/184.jpg","address":"London, England","time":"8 minutes"},{"title":"Kaehler Omaggio Laterne","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=36&rewrite=kaehler-omaggio-laterne&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/9\/0\/190.jpg","address":"Alaska, USA","time":"56 minutes"},{"title":"Le Klint Le Klint Swirl","product_link":"https:\/\/prestashop17.joommasters.com\/molla\/index.php?id_product=37&rewrite=le-klintle-klint-swirl-1-medium-pendelleuchte&controller=product&id_lang=1","image_link":"https:\/\/prestashop17.joommasters.com\/molla\/img\/p\/1\/9\/5\/195.jpg","address":"Paris, France","time":"39 minutes"}]';
            popup.popup_content = data.popup_content;

            if (data.product) {
                popup.id = data.product;
            }
            popup.init();
        }

        jQuery('#popup-close').on('click', function () {
            woorebought.popup_hide();
        });
    });
</script>
</body>
</html>