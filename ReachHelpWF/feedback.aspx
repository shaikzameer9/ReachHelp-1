<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="ReachHelpWF.feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .feedback {
            margin:16px auto;
        }
            .feedback .title{
                padding: 10px 0;
                font-variant: all-petite-caps;
                font-size: 4rem;
            }

            .feedback .desc{
                padding: 10px 0;
            }

            .feedback .type-radio-group{
                padding: 19px 0;
            }

                .feedback .type-radio-group label{
                    margin-right: 5%;
                    font-weight: 500;
                }

            .feedback #lblName, .feedback #lblEmail{
                display: block;
            }

            .feedback .name-group{
                display:block;
            }

                .feedback #firstname,.feedback #lastname{
                    width: 25%;
                    display: inline;
                }

                .feedback #email{
                    width: 50%;
                }   


        .divider{
            height: 2px;
            width: 100%;
            display: block;
            border: 1px solid #e4e4e4;
            margin: 20px 0;
        }

        .validate-msg {
            font-size: 0.8rem;
            display:none;
        }

        .valid {
            color:green;
        }

        .error {            
            color: red;
        }

    </style>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container feedback">
        <h1 class="title">Feedback</h1>
        <p class="desc">We would like to hear your thoughts, concerns or suggestions!</p>

        <div class="divider"></div>

        <label>Feedback Type <sup style="color:red">*</sup></label>
        <div class="type-radio-group">
            <label>
            <input type="radio" name="feedbackType" value="General feedback" class="feedbackType icheck-radio" checked /> General feedback
                </label>
            <label>
            <input type="radio" name="feedbackType" value="Complaint" class="feedbackType icheck-radio"  /> Complaint
                </label>
            <label>
            <input type="radio" name="feedbackType" value="Compliment" class="feedbackType icheck-radio" /> Compliment
                </label>
        </div>
        <div class="form-group">
            <label>Enter Feedback <sup style="color:red">*</sup></label>
            <textarea class="form-control" id="feedbackDescription" rows="10" minlength="10" maxlength="1000" placeholder=""></textarea>
            <i class="validate-msg error" id="desc_validate">Description error</i>
        </div>        


        <div class="form-group">
            <label id="lblName">Name <sup style="color:red">*</sup></label>
            <div class="name-group">
                <input class="form-control" type="text" id="firstname" placeholder="Firstname" />
                <input class="form-control" type="text" id="lastname" placeholder="Lastname" />
            </div>
            <i class="validate-msg error" id="name_validate">Name error</i>
        </div>

        <div class="form-group">
            <label id="lblEmail">Email <sup style="color:red">*</sup></label>
            <input class="form-control" type="email" id="email" placeholder="Email" />
            <i class="validate-msg error" id="email_validate">Email error</i>
        </div>

        <button class="btn btn-md btn-success" type="button" id="btnSubmitFeedback">Submit</button>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">    

    <script type="text/javascript">
        $('#btnSubmitFeedback').on('click', function () {
            var feedbackType = $('input[name="feedbackType"]:checked').val(),
                feedbackDescription = $('#feedbackDescription').val(),
                firstname = $('#firstname').val(),
                lastname = $('#lastname').val(),
                email = $('#email').val();

            var obj = {
                type:feedbackType,
                description:feedbackDescription,
                firstname:firstname,
                lastname:lastname,
                email:email
            };

            if (feedbackDescription == "") {
                $('#desc_validate').text('Description cannot be left empty.').show();
                return false;
            }
            $('#desc_validate').text('').hide();

            if (firstname == "") {
                $('#name_validate').text('Firstname cannot be left empty.').show();
                return false;
            }
            $('#name_validate').text('').hide();

            if (lastname == "") {
                $('#name_validate').text('Lastname cannot be left empty.').show();
                return false;
            }
            $('#name_validate').text('').hide();

            if (email == "") {
                $('#email_validate').text('Email cannot be left empty.').show();
                return false;
            }

            if (!validateEmail(email)) {
                $('#email_validate').text('Invalid Email.').show();
                return false;
            }

            $('#desc_validate,#name_validate,#email_validate').text('').hide();

            console.info("Feedback Details: ", obj);

            $.appPost('./index.aspx/sendFeedback', obj).then(function (resp) {
                console.info(resp);
                if (resp.d.indexOf("Email sent successfully") > -1) {
                    swal({ type: "success", icon: "success", text: "Feedback sent successfully.", button: false, timer: 2000 });
                    $('#feedbackDescription,#firstname,#lastname,#email').val('');
                }
                else {
                    swal({ type: "error", icon: "error", text: "Could not send Feedback. Please try again!", button: false, timer: 2000 });
                }
                
            });

        });

        $('#feedbackDescription').on('focusout', function () {
            var desc = $(this).val();
            if (desc.length < 10) {
                $('#desc_validate').text('Description should be more than 10 characters in length.').show();
                return false;
            }
            if (desc.length > 1000) {
                $('#desc_validate').text('Description should be less than 1000 characters in length.').show();
                return false;
            }
            $('#desc_validate').text('').hide();
        });             
        

        function validateEmail(email) {
            var re = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/
            return re.test(email);
        }



    </script>

</asp:Content>
