<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="privacy.aspx.cs" Inherits="ReachHelpWF.privacy_policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .privacy-policy {
                line-height: 1.5rem;
    text-align: justify;
        }

        .roman-uc {
            list-style-type: upper-roman;
        }

        .roman-lc {
            list-style-type: lower-roman;
        }

        .policy-list > li {
            margin: 40px 0;
        }

        /*.policy-list p {
            padding: 15px 0;
        }*/

        .policy-list {
            margin: 0 0 1.5em;
            padding: 0;
            counter-reset: item;
        }

            .policy-list > li {
                margin: 0;
                /*padding: 0 0 0 2em;*/
                padding:1em 0;
                /*text-indent: -2em;*/
                list-style-type: none;
                counter-increment: item;
            }

                .policy-list > li > h3 {
                    display: inline !important;
                }

                .policy-list > li:before {
                    display: inline-block;
                    width: 1em;
                    padding-right: 0.5em;
                    font-weight: bold;
                    font-size: 1.4rem;
                    text-align: right;
                    content: counter(item) ".";
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container privacy-policy">
        <h2 class="w3_agile_header">Reachelp Privacy Policy</h2>
        <small style="text-align: center; display:block;font-style:italic">Last Modified: <strong>March 26, 2019</strong></small>
        <ol class="policy-list">
            <li>
                <h3>INFORMATION COLLECTION AND USE</h3>
                <p>ReacHelp knows that you care how information about you is collected, used and shared, and we appreciate you trusting us to do so carefully and sensibly. ReacHelp respects the privacy of its online visitors and customers of its products and services and complies with applicable laws for the protection of your privacy, including, without limitation, those that apply to the United States  as well as the European Union General Data Protection Regulation ("GDPR") and the Swiss and EU Privacy Shield Frameworks. Please take a moment to review our Privacy Policy which describes how ReachHelp collects, uses, and shares this and other information.</p>
                <p>There may be a variety of information collected from or about you when you use the ReachHelp Services, including:</p>
                <ol class="roman-uc">
                    <li>Information you give us, such as during registration ;</li>
                    <li>Information automatically collected when you visit ReacHelp or use  ReacHelp Services, such as your location and information collected via cookies, web beacons or other technologies;</li>
                    <li>Information from other commercially available sources, such as data aggregators and public databases, or our business partners.</li>
                </ol>
                <p>ReacHelp uses the information we collect in the following ways to:</p>
                <ol class="roman-uc">
                    <li>contact you;</li>
                    <li>customize the content and advertising you view;</li>
                    <li>fulfill your requests for products or services;</li>
                    <li>improve our services;</li>
                    <li>prevent potentially illegal activities; and</li>
                    <li>protect our rights.</li>
                </ol>
            </li>
            <li>
                <h3>INFORMATION SHARING AND DISCLOSURE</h3>
                <p>We may share information that we collect about you to provide the ReachHelp Services, including:</p>
                <ol class="roman-uc">
                    <li>With social networking services with your consent;</li>
                    <li>With other business partners with your consent;</li>
                    <li>In aggregated or other non-personally identifiable form; or</li>
                    <li>When necessary to protect or defend the rights of ReachHelp or our users, and</li>
                    <li>When required by law or public authorities.</li>
                </ol>
            </li>
            <li>
                <h3>YOUR RIGHTS AND CONTROL MECHANISMS</h3>
                <p>The data protection laws of the European Economic Area and other territories grant their citizens certain rights in relation to their Personal Data. While other jurisdictions including the United States may provide fewer statutory rights to their citizens, we make tools designed to exercise such rights available to our customers worldwide.</p>
                <ol class="roman-uc">
                    <li>
                        <p><strong>Right of Access.</strong> You have the right to access your Personal Data that we hold, i.e. the right to require free of charge</p>
                        <ol class="roman-lc">
                            <li>information whether your Personal Data is retained,</li>
                            <li>access to and/or</li>
                            <li>duplicates of the Personal Data retained</li>
                        </ol>
                        <p>You can use the right to access to your Personal Data through the Privacy Settings. If the request affects the rights and freedoms of others or is manifestly unfounded or excessive, we reserve the right to charge a reasonable fee (taking into account the administrative costs of providing the information or communication or taking the action requested) or to refuse to act on the request.</p></li>
                    <li><p><strong>Right to Rectification.</strong> If we process your Personal Data, we shall endeavor to ensure by implementing suitable measures that your Personal Data is accurate and up-to-date for the purposes for which it was collected. If your Personal Data is inaccurate or incomplete, you can change the information you provided via the Privacy Settings.</p></li>
                    <li><p><strong>Right to Erasure.</strong> You have the right to obtain deletion by us of Personal Data concerning you by deleting your ReacHelp User Account via the ReacHelp support page. As a result of deleting your ReacHelp User Account, you will lose access to ReacHelp services, including the ReacHelp User Account, Subscriptions and information linked to the ReacHelp User Account and the possibility to access other services you are using the ReacHelp User Account for. We allow you to restore your ReacHelp User Account during a grace period of 30 (thirty) days from the moment you request deletion of your ReachHelp User Account. This functionality allows you not to lose your account by mistake, because of your loss of your account credentials or due to hacking. During the suspension period, we will be able to finalize financial and other activities that you may have initiated before sending the ReacHelp User Account deletion request. After the grace period, Personal Data associated with your account will be deleted. In some cases, deletion of your ReacHelp User Account, and therefore Personal Data deletion, is complicated. In such instances, considering the complexity and number of the requests, the period for Personal Data erasure may be extended, but for no longer than two further months.</p></li>
                    <li><p><strong>Right to Object.</strong> When our processing of your Personal Data is based on legitimate interests according to Article 6(1) (f) of the GDPR / section 2.c) of this Privacy Policy, you have the right to object to these processing. If you object we will no longer process your Personal Data unless there are compelling and prevailing legitimate grounds for the processing as described in Article 21 of the GDPR; in particular if the data is necessary for the establishment, exercise or defense of legal claims. You also have the right to lodge a complaint at a supervisory authority.</p></li>
                </ol>
            </li>
            <li>
                <h3>CHILDREN</h3>
                <p>ReacHelp prohibits anyone under 13 years of age from using its services and we will not knowingly collect personally identifiable information from anyone under 13.</p>
            </li>
            <li>
                <h3>SECURITY</h3>
                <p>We have adopted commercially reasonable procedures to help protect your information, but please note that no data transmission or storage can be guaranteed to be 100% secure.</p>
            </li>
            <li>
                <h3>ADVERTISEMENTS AND TRACKING COOKIES</h3>
                <p>Advertisers use tracking cookies to find your preferences and interests and serve ads based on it. You may visit the advertisers’ website to opt out of the use of cookies for interest-based advertising.</p>
                <ol class="roman-uc">
                    <li><p>Google's uses the DoubleClick cookie to serve ads to you based on your visit to ReachHelp and/or other sites on the Internet.</p></li>
                </ol>
                <p>If you have not opted out of third-party ad serving, the cookies of other third-party vendors or ad networks may also be used to serve ads to you.</p>
            </li>
        </ol>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
