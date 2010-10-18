$(function() {
        $("#greeting").greet();
        form = $("#comment_form");
        $.fn.movabletype.fetchUser();
        user = $.fn.movabletype.getUser();

        form.submit(function() {
                $("#armor", this).val(mt.blog.comments.armor);
                return true;
        });
        form.onauthchange(function(evt, user) {
                if (user.is_authenticated)
                {
                        $("#author", form).val(user.name).parent().hide();
                        $("#email", form).val(user.email).parent().hide();
                        $("#url", form).val(user.url).parent().hide();
                }
        });
});
