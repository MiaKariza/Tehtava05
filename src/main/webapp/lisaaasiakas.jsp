<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
	<form id="tiedot">
		<table class="table table-dark table-striped">
			<thead>
				<th colspan="4"><span id="takaisin">Takaisin asiakaslistaan</span></th>
				<tr>
					<th>Etunimi</th>
					<th>Sukunimi</th>
					<th>Puhelin</th>
					<th>Sähköposti</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="etunimi" id="etunimi"></td>
					<td><input type="text" name="sukunimi" id="sukunimi"></td>
					<td><input type="text" name="puhelin" id="puhelin"></td>
					<td><input type="text" name="sposti" id="sposti"></td>
					<td><input type="submit" id="tallenna" value="Lisää"></td>
				</tr>
			</tbody>
		</table>
	</form>
	<span id="viesti"></span>

</body>

<script>

$(document).ready(function() {
	$("#tiedot").validate({
		rules: {
			etunimi: {
				required: true,
				minlength: 2
			},
			sukunimi: {
				required: true,
				minlength: 2				
			},
			puhelin: {
				required: true,
				number: true				
			},
			sposti: {
				required: true,
				email: true				
			}
		},
		messages: {
			etunimi: {
				required: "Etunimi puuttuu",
				minlength: "Etunimi on liian lyhyt"
			},
			sukunimi: {
				required: "Sukunimi puuttuu",
				minlength: "Sukunimi on liian lyhyt"				
			},
			puhelin: {
				required: "Puhelinnumero puuttuu",
				number: "Tarkista puhelinnumero"				
			},
			sposti: {
				required: "Sähköpostiosoite puuttuu",
				email: "Anna toimiva sähköpostiosoite"				
			}
			
		},
		submitHandler: function(form) {
			lisaaTiedot();
		}
	
	});
});

function lisaaTiedot() {
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat/", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {
		if (result.response == 0) {
			$("#viesti").html("Asiakkaan lisääminen epäonnistui");
		}else if (result.response == 1) {
			$("#viesti").html("Asiakkaan lisääminen onnistui");
			$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");			
		}
	}});
}

</script>
</html>