<template>
    <div class="row justify-content-center">
        <div class="col-xs-12 col-sm-6 col-md-6">
            <div class="card card-body">
                <div class="row align-items-center">
                    <div class="col-sm-6 col-md-4">
                        <img src="http://placehold.it/380x500" alt="" class="rounded img-fluid" />
                    </div>
                    <div class="col-sm-6 col-md-8">
                        <h4>Carlos Zapata</h4>
                        <small><cite title="Valencia, Carabobo">Valencia, Carabobo</cite></small>
                        <p>
                            carloszapatac17@gmail.com
                            <br />
                            CI: 27.488.851
                            <br />
                            Febrero 17, 1998</p>
                        <!-- Split button -->
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary">Editar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
