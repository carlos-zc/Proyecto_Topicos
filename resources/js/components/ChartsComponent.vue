<template>
    <!-- resources/assets/js/components -->
    <div>
        <div style="width:100%; height:50%">
            <canvas id="munChart" width="200" height="100"></canvas>
        </div>
        <div style="margin-top:7%" class="row">
            <div style="height:40%" class="col-md">
                <canvas id="tipChart" align="center" width="50" height="50"></canvas>
            </div>
            <div style="height:40%" class="col-md">
                <canvas id="priceChart" width="50" height="50"></canvas>
            </div>
        </div>
    </div>
    
</template>

<script>
    import Chart from 'chart.js';

    export default {
        data(){
            return{
                municipios:[],
                cantidad:[],
                tipo_inmueble:[],
                cant_tipo:[],
                nombre_public:[],
                precio_public:[]
            }
        },
        props: {
            labels: String,
            dataProp: String
        },
        methods: {
            rendermunChart() {
                var munChart = document.getElementById("munChart").getContext("2d");
                var myChart = new Chart(munChart, {
                    type:"bar",
                    data:{
                        //labels:['Casa', 'Quinta', 'Townhouse', 'Apartamento'],
                        labels:this.municipios,
                        datasets:[{
                            label:'Inmuebles en Venta',
                            data:this.cantidad,
                            backgroundColor: [
                            'rgba(0, 55, 89, 0.5)', //Azul
                            'rgba(54, 66, 118, 0.5)', //Morado Oscuro
                            'rgba(108, 72, 136, 0.5)', 
                            'rgba(163, 72, 138, 0.5)',
                            'rgba(212, 75, 124, 0.5)',
                            'rgba(246, 91, 98, 0.5)',
                            'rgba(255, 124, 63, 0.5)',
                            'rgba(255, 166, 0, 0.5)',
                            'rgba(255, 219, 15, 0.5)'
                        ],
                        borderColor: [
                            'rgba(0, 55, 89, 1)',
                            'rgba(54, 66, 118, 1)',
                            'rgba(108, 72, 136, 1)',
                            'rgba(163, 72, 138, 1)',
                            'rgba(212, 75, 124, 1)',
                            'rgba(246, 91, 98, 1)',
                            'rgba(255, 124, 63, 1)',
                            'rgba(255, 166, 0, 1)',
                            'rgba(255, 219, 15, 1)'
                        ],
                        borderWidth: 1
                        }]
                    },
                    options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    },
                    title:{
                        display:true,
                            text:'Cantidad de Publicaciones por Municipio',
                            fontSize:20
                    }
                }
                });
            },
            rendertipChart(){
                var tipChart = document.getElementById("tipChart").getContext("2d");
                var myChart = new Chart(tipChart, {
                    type:"doughnut",
                    data:{
                        //labels:['Casa', 'Quinta', 'Townhouse', 'Apartamento'],
                        labels:this.tipo_inmueble,
                        datasets:[{
                            label:'Tipo de Inmueble mas Vendido',
                            data:this.cant_tipo,
                            backgroundColor: [
                            'rgba(1, 0, 89, 0.5)', //Azul
                            'rgba(168, 0, 91, 0.5)',
                            'rgba(250, 96, 52, 0.5)',
                            'rgba(255, 166, 0, 0.5)'
                        ],
                        borderColor: [
                            'rgba(1, 0, 89, 1)',
                            'rgba(168, 0, 91, 1)',
                            'rgba(250, 96, 52, 1)',
                            'rgba(255, 166, 0, 1)'
                        ],
                        borderWidth: 1
                        }]
                    },
                    options:{
                        title:{
                            display:true,
                            text:'Cantidad de Publicaciones por Tipo de Inmueble',
                            fontSize:15
                        }
                    }
                });
                
            },
            renderpriceChart(){
                var tipChart = document.getElementById("priceChart").getContext("2d");
                var myChart = new Chart(tipChart, {
                    type:"doughnut",
                    data:{
                        //labels:['Casa', 'Quinta', 'Townhouse', 'Apartamento'],
                        labels:this.nombre_public,
                        datasets:[{
                            label:'Tipo de Inmueble mas Vendido',
                            data:this.precio_public,
                            backgroundColor: [
                            'rgba(1, 0, 89, 0.5)', //Azul
                            'rgba(104, 0, 96, 0.5)',
                            'rgba(170, 0, 88, 0.5)',
                            'rgba(218, 34, 70, 0.5)',
                            'rgba(247, 103, 44, 0.5)',
                            'rgba(255, 166, 0, 0.5)'
                        ],
                        borderColor: [
                            'rgba(1, 0, 89, 1)', //Azul
                            'rgba(104, 0, 96, 1)',
                            'rgba(170, 0, 88, 1)',
                            'rgba(218, 34, 70, 1)',
                            'rgba(247, 103, 44, 1)',
                            'rgba(255, 166, 0, 1)'
                        ],
                        borderWidth: 1
                        }]
                    },
                    options:{
                        title:{
                            display:true,
                            text:'Propiedades de Mayor Valor',
                            fontSize:15
                        }
                    }
                });
                
            }
        },
        created(){
            axios.get('venta-grafico').then(response =>{
                
                var array=response.data;
                for(var i = 0; i < array.length; i++){
                    console.log(array[i].cantidad_mun);
                    this.municipios.push(array[i].municipio);
                    this.cantidad.push(array[i].cantidad_mun);
                }
                this.rendermunChart();
            });

            axios.get('tipo-grafico').then(response =>{
                var array=response.data;
                for(var i = 0; i < array.length; i++){
                    console.log(array[i].cantidad_tipo);
                    console.log(array[i].tipo);
                    this.tipo_inmueble.push(array[i].tipo);
                    this.cant_tipo.push(array[i].cantidad_tipo);
                }
                this.rendertipChart();
            });

            axios.get('precio-grafico').then(response =>{
                var array=response.data;
                for(var i = 0; i < array.length; i++){
                    console.log(array[i].cantidad_tipo);
                    console.log(array[i].tipo);
                    this.nombre_public.push(array[i].nombre);
                    this.precio_public.push(array[i].precio);
                }
                this.renderpriceChart();
            });
            
        }
    }

</script>
