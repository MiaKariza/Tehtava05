<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link herf = "css/main.css" rel = "stylesheet">   <!-- ei tomi -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakkaat</title>
</head>
<body>
<p></p>
<h1 class="container">Asiakkaat</h1>
<p></p>

	<div class="container">

		<form class="row g-3 align-items-center">
			<div class="col-md-10">
				<input class="form-control" type="text" id="hakusana" name="hakusana" placeholder="Hakusana">
			</div>
			<div class="col-md">
				<input class="btn btn-dark" type="button" value="hae" id="hakunappi">
			</div>
		</form>
		<div class="mt-5">
		<table class="table table-dark table-striped" id="lista">
			<thead><tr>
			<th colspan="5" class="align-right"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>	
				<tr>
					<th>Etunimi</th>
					<th>Sukunimi</th>
					<th>Puhelin</th>
					<th>Sähköposti</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			</tbody>

		</table>
		</div>

	</div>

	<script>
		$(document).ready(function() {
			
			$("#uusiAsiakas").click(function() {
				document.location = "lisaaasiakas.jsp";
			});

			haeAsiakkaat();

			$("#hakunappi").click(function() {
				haeAsiakkaat();
			});
			
			$(document.body).on("keydown", function(event){
				  if(event.keyCode==13){ 
					  event.preventDefault();
					  haeAsiakkaat();
				  }
			});

			$("#hakusana").focus();
		});

		function haeAsiakkaat() {
			$("#lista tbody").empty();
			$.ajax({
				url : "asiakkaat/" + $("#hakusana").val(),
				type : "GET",
				dataType : "json",
				success : function(response) {
					$.each(response.asiakkaat, function(x, tieto) {
						var html;
						html += "<tr id='rivi_"+tieto.asiakas_id+"'>";
						html += "<td>" + tieto.etunimi + "</td>"
						html += "<td>" + tieto.sukunimi + "</td>"
						html += "<td>" + tieto.puhelin + "</td>"
						html += "<td>" + tieto.sposti + "</td>"
						html += "<td><span onclick = 'poista("+tieto.asiakas_id+")' class='btn bg-white text-dark'>Poista</span></td>";
						html += "</tr>";
						$("#lista tbody").append(html);
					});
				}
			});
		}
		
		function poista(asiakas_id) {
			console.log(asiakas_id);
			if(confirm("Poista asiakas " + asiakas_id + "?")) {
				$.ajax({
				url:"asiakkaat/" + asiakas_id,
				type: "DELETE",
				dataType: "json",
				success:function(response) {
					if(response == 0) {
						$("#viesti").html("Asiakkaan poisto epäonnistui");
					} else if (response == 1) {
						$("#rivi_" + tieto.asiakas_id).css("background-color", "red"); //Miksi tämä ei toimi?
						alert("Asiakkaan poisto onnistui");
					}
					haeAsiakkaat();
					}});
				}
			
		}
	</script>

</body>
</html>


