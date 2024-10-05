@extends('layouts.app',
        $vars=[ 'breadcrum' => ['Home'],
                'title'=>'Geo Planner Localización',
                'activeMenu'=>'0'
              ])
@section('content')
<div class="container-fluid">
    <div class="card-body">
        <div class="col-md-12">
            <form id="filter-form">
                <div class="row">
                    <div class="form-group col-md-4">
                        <label for="fecha">Fecha</label>
                        <input type="date" id="fecha" name="fecha" class="form-control form-control-sm" value="{{ session('fecha') }}" disabled>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="latitud">Latitud</label>
                        <input type="text" id="latitud" name="latitud" class="form-control form-control-sm" value="{{ session('latitud') }}" disabled>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="longitud">Longitud</label>
                        <input type="text" id="longitud" name="longitud" class="form-control form-control-sm" value="{{ session('longitud') }}" disabled>
                    </div>
                </div>
            </form>
            <div id="map" style="height: 500px; width: 100%; margin-top: 20px;"></div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
<script type="text/javascript">
   document.addEventListener('DOMContentLoaded', function() {
    initMap();

    fetch('/rpa-coordinates')
        .then(response => response.json())
        .then(data => {
            data.forEach(location => {
                addMarkerAndCircle(location.latitud, location.longitud);
            });

            if (data.length > 0) {
                map.setView([data[0].latitud, data[0].longitud], 13); // Centrar el mapa en la primera coordenada
            }
        });
});

function initMap() {
    map = L.map('map').setView([4.7110, -74.0721], 12); // Centrado en Bogotá
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
}

function addMarkerAndCircle(lat, lng) {
    const marker = L.marker([lat, lng]).addTo(map);
    markers.push(marker);

    const circle = L.circle([lat, lng], {
        color: 'red',
        fillColor: '#f03',
        fillOpacity: 0.2,
        radius: 500
    }).addTo(map);
    circles.push(circle);
}

</script>
@endsection


