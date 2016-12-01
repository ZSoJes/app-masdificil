$(document).ready(function() {
    $(function() {
        //VALIDACIONES EN EL CLIENTE JQUERY
        var emailreg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
        var passreg = /(?=.{8,})(?=.*[A-Z])(?=.*[0-9])(?![.\n])((?=.*\d)|(?=.*\W+))(?=.*[a-z]).*/
        var modal_login = document.getElementById('id01');
        var modal_sign = document.getElementById('id02');

        $(".boton").click(function(c) {
            c.preventDefault();
            var nombre = $("#id02").find(".nombre").val();
            var email = $("#id02").find(".email").val();
            var pass = $("#id02").find(".pass").val();
            if (nombre == '' || email == '' || pass == '') {
                alert("No puedes dejar campos vacios");
            } else {
                $.post('/signup', {
                    nombre: nombre,
                    email: email,
                    pass: pass
                }, function(data) {
                    $(".carrousel").remove();
                    $(".perro").remove();
                    $(".contenido").empty();
                    // $(".contenidotweet").empty();
                    $(".contenido").prepend(data);
                    //  console.log(data);

                });

                modal_sign.style.display = "none";
            }

            $(".error").fadeOut().remove();

        });


        // login

        $(".boton_login").click(function(d) {
            d.preventDefault();
            var email = $("#id01").find(".email_login").val();
            var pass = $("#id01").find(".pass_login").val();
            if (email == '' || pass == '') {
                alert("No puedes dejar campos vacios");
            } else {
                $.post('/login', {
                    email: email,
                    pass: pass
                }, function(data) {
                    $(".carrousel").remove();
                    $(".perro").remove();
                    $(".contenido").prepend(data);
                    //  console.log(data);

                });

                modal_login.style.display = "none";
            }

        });


        $(".adoptar").click(function(a) {
            a.preventDefault();
            $.get('/adoptar', {}, function(data) {
                $(".contenido").empty();
                $(".carrousel").remove();
                $(".perro").remove();
                $(".contenido").prepend(data);
                //  console.log(data);

            });
        });


        $(".necesidades").click(function(a) {
            a.preventDefault();
            $.get('/necesidades', {}, function(data) {
                $(".contenido").empty();
                $(".carrousel").remove();
                $(".perro").remove();
                $(".contenido").prepend(data);
                //  console.log(data);

            });
        });

        var show = 0;
        $(".mostrar_adop").click(function (a) {
            if (show == 0){
              $("#form_hidden").css("display","block");
              show = 1;
            }else if(show == 1){
              $("#form_hidden").css("display","none");
              show = 0;
            }
        });


    });

    //CARROUSEL
    //https://www.youtube.com/watch?v=I00i_NmLSzw
    var SliderModule = (function() {
        var pb = {};
        pb.el = $('#slider');
        pb.items = {
                panels: pb.el.find('.slider-wrapper > li'),
            }
            // Interval del Slider Variables
        var SliderInterval,
            currentSlider = 0,
            nextSlider = 1,
            lengthSlider = pb.items.panels.length;

        // Constructor del Slider
        pb.init = function(settings) {
            //console.log('Inicializado';)
            this.settings = settings || {
                duration: 8000
            };
            var items = this.items,
                lengthPanels = items.panels.length,
                output = '';

            // Insertamos nuestros botones
            for (var i = 0; i < lengthPanels; i++) {
                if (i == 0) {
                    output += '<li class="active"></li>';
                } else {
                    output += '<li></li>';
                }
            }

            $('#control-buttons').html(output);

            // Activamos nuestro Slider
            activateSlider();
            // Eventos para los controles
            $('#control-buttons').on('click', 'li', function(e) {
                var $this = $(this);
                if (!(currentSlider === $this.index())) {
                    changePanel($this.index());
                }
            });

        }

        // Funcion para activar el Slider
        var activateSlider = function() {
            SliderInterval = setInterval(pb.startSlider, pb.settings.duration);
        }

        // Funcion para la Animacion
        pb.startSlider = function() {
            var items = pb.items,
                controls = $('#control-buttons li');
            // Comprobamos si es el ultimo panel para reiniciar el conteo
            if (nextSlider >= lengthSlider) {
                nextSlider = 0;
                currentSlider = lengthSlider - 1;
            }

            controls.removeClass('active').eq(nextSlider).addClass('active');
            items.panels.eq(currentSlider).fadeOut('slow');
            items.panels.eq(nextSlider).fadeIn('slow');

            // Actualizamos los datos del slider
            currentSlider = nextSlider;
            nextSlider += 1;
        }

        // Funcion para Cambiar de Panel con Los Controles
        var changePanel = function(id) {
            clearInterval(SliderInterval);
            var items = pb.items,
                controls = $('#control-buttons li');
            // Comprobamos si el ID esta disponible entre los paneles
            if (id >= lengthSlider) {
                id = 0;
            } else if (id < 0) {
                id = lengthSlider - 1;
            }

            controls.removeClass('active').eq(id).addClass('active');
            items.panels.eq(currentSlider).fadeOut('slow');
            items.panels.eq(id).fadeIn('slow');

            // Volvemos a actualizar los datos del slider
            currentSlider = id;
            nextSlider = id + 1;
            // Reactivamos nuestro slider
            activateSlider();
        }

        return pb;
    }());

    SliderModule.init({
        duration: 4000
    });

    // _________________________________asincrono profile



    //______________________________________modal
    var modal = document.getElementById('id01');
    var modal2 = document.getElementById('id02');
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        if (event.target == modal2) {
            modal2.style.display = "none";
        }
    }

});
