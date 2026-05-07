function filterActivities() {

  const city = document.getElementById("citySelect").value;
  const category = document.getElementById("categorySelect").value;

  alert("Kerkim per: " + city + " | " + category);
}

function bookActivity(activity) {

  alert("Rezervimi per " + activity + " u krye me sukses!");

}

document.getElementById("bookingForm").addEventListener("submit", function(e){

  e.preventDefault();

  alert("Pagesa u krye me sukses!");

});

document.getElementById("loginForm").addEventListener("submit", function(e){

  e.preventDefault();

  alert("Login Successful!");

});

function getAIRecommendation() {

  const input = document.getElementById("aiInput").value.toLowerCase();

  let recommendation = "";

  if(input.includes("beach")) {

    recommendation = "AI Sugjeron: Ksamil, Dhërmi ose Himarë";

  }

  else if(input.includes("mountain")) {

    recommendation = "AI Sugjeron: Theth, Valbonë ose Dardhë";

  }

  else if(input.includes("nightlife")) {

    recommendation = "AI Sugjeron: Tirana ose Saranda";

  }

  else {

    recommendation = "AI Sugjeron: Berat City Tour";

  }

  document.getElementById("aiResult").innerHTML = recommendation;
}

function initMap() {

  navigator.geolocation.getCurrentPosition(position => {

    const location = {

      lat: position.coords.latitude,
      lng: position.coords.longitude

    };

    const map = new google.maps.Map(document.getElementById("map"), {

      zoom: 10,
      center: location

    });

    new google.maps.Marker({

      position: location,
      map: map,
      title: "Vendndodhja Juaj"

    });

  });

}

window.onload = initMap;