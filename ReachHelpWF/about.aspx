<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="ReachHelpWF.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- about -->
	<div class="about">
		<div class="container">
			<h3 class="w3_agile_header">About Us</h3>
			<div class="about-agileinfo w3layouts">
				<div class="col-md-12 about-wthree-grids grid-top">
					<%--<h4>Blanditiis praesentium deleniti atque corrupti quos </h4>--%>
					<%--<p class="top">Gnissimos voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi. atque corrupti quos dolores et quas molestias excepturi sint occaecat officia deserunt mollitia laborum et dolorum fuga</p>--%>
					<p>ReacHelp provides a platform for those who need help to connect to those who can provide  it. The primary focus of ReacHelp is on goods and services. You can learn more by exploring the goods and services pages respectively. There is no charge for your use of ReacHelp and those providing goods or services should not be charging either (though shipping costs can be extra). If you have thoughts on how to improve ReacHelp, please share them with us through the “Feedback” page. We hope you will benefit from ReacHelp!</p>		
					<div class="about-w3agilerow">
						<div class="col-md-4 about-w3imgs">
							<img src="img/aboutus_1.png" alt="" class="img-responsive zoom-img"/>
						</div>
						<div class="col-md-4 about-w3imgs">
							<img src="img/aboutus_2.png" alt=""  class="img-responsive zoom-img"/>
						</div>
						<div class="col-md-4 about-w3imgs">
							<img src="img/aboutus_1.png" alt=""  class="img-responsive zoom-img"/>
						</div>
						<div class="clearfix"> </div>
					</div>
				</div>
				<%--<div class="col-md-4 about-wthree-grids">
					<div class="offic-time">
						<div class="time-top">
							<h4>Praesentium :</h4>
						</div>
						<div class="time-bottom">
							<h5>At vero eos </h5>
							<h5>Accusamus et</h5>
							<p>Dignissimos at vero eos et accusamus et iusto odio ducimus qui accusamus et. </p>
						</div>
					</div>
					<div class="testi">
						<h3 class="w3_agile_header">Testimonial</h3>
						<!--//End-slider-script -->
						<script src="js/responsiveslides.min.js"></script>
						 <script>
						     // You can also use "$(window).load(function() {"
						     $(function () {
						         // Slideshow 5
						         $("#slider5").responsiveSlides({
						             auto: true,
						             pager: false,
						             nav: true,
						             speed: 500,
						             namespace: "callbacks",
						             before: function () {
						                 $('.events').append("<li>before event fired.</li>");
						             },
						             after: function () {
						                 $('.events').append("<li>after event fired.</li>");
						             }
						         });

						     });
						  </script>
						<div  id="top" class="callbacks_container">
							<ul class="rslides" id="slider5">
								<li>
									<div class="testi-slider">
										<h4>" I AM VERY PLEASED.</h4>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu magna dolor, quisque semper.</p>
										<div class="testi-subscript">
											<p><a href="#">John Doe,</a>Adipiscing</p>
											<span class="w3-agilesub"> </span>
										</div>	
									</div>
								</li>
								<li>
									<div class="testi-slider">
										<h4>" I AM LOREM IPSUM.</h4>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu magna dolor, quisque semper.</p>
										<div class="testi-subscript">
											<p><a href="#">elit semper,</a>Dolor Elit</p>
											<span class="w3-agilesub"> </span>
										</div>	
									</div>
								</li>
								<li>
									<div class="testi-slider">
										<h4>" CONSECTETUR PIMAGNA.</h4>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu magna dolor, quisque semper.</p>
										<div class="testi-subscript">
											<p><a href="#">Amet Doe,</a>Suspendisse</p>
											<span class="w3-agilesub"> </span>
										</div>	
									</div>
								</li>
							</ul>	
						</div>
					</div>
				</div>	--%>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<!-- //about -->
	<!-- about-slid -->
	<div class="about-slid agileits-w3layouts"> 
		<div class="container">
			<div class="about-slid-info"> 
				<h2>Purpose</h2>
				<p>ReacHelp provides a platform for those who need help to connect to those who can provide  it. The primary focus of ReacHelp is on goods and services. You can learn more by exploring the goods and services pages respectively. There is no charge for your use of ReacHelp and those providing goods or services should not be charging either (though shipping costs can be extra). If you have thoughts on how to improve ReacHelp, please feel free to send us feedback through the “Contact” page. We hope you will benefit from ReacHelp!</p>
			</div>
		</div>
	</div>
	<!-- //about-slid -->
	<!-- about-team -->
	<%--<div class="about-team"> 
		<div class="container">
			<h3 class="w3_agile_header">Meet Our Team</h3>
			<div class="team-agileitsinfo">
				<div class="col-md-3 about-team-grids">
					<img src="https://via.placeholder.com/250x335.jpg?text=Manager" alt=""/>
					<div class="team-w3lstext">
						<h4><span>ANDERSON,</span> Manager</h4>
						<p>Odio dignissimos vero eos voluptatem accusantium doloremque laudantium reader will be distracted.</p>
					</div>
					<div class="social-icons caption"> 
						<ul>
							<li><a href="#" class="fa fa-facebook facebook"> </a></li>
							<li><a href="#" class="fa fa-twitter twitter"> </a></li>
							<li><a href="#" class="fa fa-google-plus googleplus"> </a></li> 
						</ul>
						<div class="clearfix"> </div>  
					</div>
				</div>
				<div class=" col-md-3 about-team-grids">
					<img src="https://via.placeholder.com/250x335.jpg?text=Director" alt=""/>
					<div class="team-w3lstext">
						<h4><span>ELIFS,</span> Director</h4>
						<p>Odio dignissimos vero eos voluptatem accusantium doloremque laudantium reader will be distracted.</p>
					</div>
					<div class="social-icons caption"> 
						<ul>
							<li><a href="#" class="fa fa-facebook facebook"> </a></li>
							<li><a href="#" class="fa fa-twitter twitter"> </a></li>
							<li><a href="#" class="fa fa-google-plus googleplus"> </a></li> 
						</ul>
						<div class="clearfix"> </div>  
					</div>
				</div>
				<div class="col-md-3 about-team-grids">
					<img src="https://via.placeholder.com/250x335.jpg?text=Supervisor" alt=""/>
					<div class="team-w3lstext">
						<h4><span>JESSICA,</span> Supervisior</h4>				
						<p>Odio dignissimos vero eos voluptatem accusantium doloremque laudantium reader will be distracted.</p>
					</div>
					<div class="social-icons caption"> 
						<ul>
							<li><a href="#" class="fa fa-facebook facebook"> </a></li>
							<li><a href="#" class="fa fa-twitter twitter"> </a></li>
							<li><a href="#" class="fa fa-google-plus googleplus"> </a></li> 
						</ul>
						<div class="clearfix"> </div>  
					</div>
				</div>
				<div class="col-md-3 about-team-grids">
					<img src="https://via.placeholder.com/250x335.jpg?text=Staff" alt=""/>
					<div class="team-w3lstext">
						<h4><span>RACKHAM,</span> Staff</h4>
						<p>Odio dignissimos vero eos voluptatem accusantium doloremque laudantium reader will be distracted.</p>
					</div>
					<div class="social-icons caption"> 
						<ul>
							<li><a href="#" class="fa fa-facebook facebook"> </a></li>
							<li><a href="#" class="fa fa-twitter twitter"> </a></li>
							<li><a href="#" class="fa fa-google-plus googleplus"> </a></li> 
						</ul>
						<div class="clearfix"> </div>  
					</div>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>--%>
	<!-- //about-team -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
