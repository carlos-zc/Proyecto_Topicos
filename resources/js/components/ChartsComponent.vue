<template>
    <!-- resources/assets/js/components -->
    <div>
        <div style="width:100%; height:50%">
            <canvas id="munChart" width="200" height="100"></canvas>
        </div>
        
        <div style="width:45%; height:45%">
            <canvas id="myChart" width="100" height="100"></canvas>
        </div>
        <div style="width:45%; height:45%">
            <canvas id="myChart" width="100" height="100"></canvas>
        </div>
    </div>
    
</template>

<script>
    import Chart from 'chart.js';

    export default {
        data(){
            return{
                municipios:[],
                cantidad:[]
            }
        },
        props: {
            labels: String,
            dataProp: String
        },
        methods: {
            renderChart() {

                var ctx = document.getElementById("munChart").getContext("2d");
                var myChart = new Chart(ctx, {
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
                    }
                }
                });


                /*new Chart(document.getElementById('myChart'), {
                type: 'bar',
                data: {
                    labels: ['Red', 'Blue', 'Yellow', 'Purple', 'Orange'],
                    datasets: [{
                        label: '# of Votes',
                        data: [12, 19, 3, 2, 3],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
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
                    }
                }
            });*/
            }
        },
        created(){
            axios.get('venta-grafico').then(response =>{
                
                var array=response.data;
                for(var i = 0; i < array.length; i++){
                    console.log('tu mama me mama');
                    console.log(array[i].cantidad_mun);
                    this.municipios.push(array[i].municipio);
                    this.cantidad.push(array[i].cantidad_mun);
                    //cantidad[i]=this.respuesta[i].cantidad_num;
                }

                this.renderChart();


            });
            
        }
    }

</script>
