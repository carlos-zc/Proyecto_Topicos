<template>
    <div class="row justify-content-center">
        <form action="" enctype="multipart/form-data" @submit.prevent="updatePerfil" v-if="modoEditar">
            <div class="card card-body">
                <h2>Actualizar Datos</h2>
                <div class="row align-items-center">
                    <div class="col-md-4">
                        <img :src="getProfilePhoto()" alt="" class="rounded img-fluid">
                        <p class="mt-4">Seleccionar otra foto <span class="font-weight-bold">(Máx. 2 Mb)</span></p>
                        <div class="form-group">
                            <input type="file" name="adjunto" @change="updateImg" class="form-control-file" accept=".jpg,.png">
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required v-model="perfil.name"
                            :class="{ 'is-invalid': perfil.errors.has('name') }">
                            <has-error :form="perfil" field="name"></has-error>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-7">
                                <label for="inputCity">Ciudad</label>
                                <input type="text" class="form-control" id="inputCity" v-model="perfil.city">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="inputState">Estado</label>
                                <select id="inputState" class="form-control" v-model="perfil.state">
                                    <option disabled value="">Elegir...</option>
                                    <option>Amazonas</option>
                                    <option>Anzoátegui</option>
                                    <option>Apure</option>
                                    <option>Aragua</option>
                                    <option>Barinas</option>
                                    <option>Bolívar</option>
                                    <option>Carabobo</option>
                                    <option>Cojedes</option>
                                    <option>Delta Amacuro</option>
                                    <option>Falcón</option>
                                    <option>Guárico</option>
                                    <option>Lara</option>
                                    <option>Miranda</option>
                                    <option>Monagas</option>
                                    <option>Mérida</option>
                                    <option>Monagas</option>
                                    <option>Mérida</option>
                                    <option>Nueva Esparta</option>
                                    <option>Portuguesa</option>
                                    <option>Sucre</option>
                                    <option>Trujillo</option>
                                    <option>Táchira</option>
                                    <option>Vargas</option>
                                    <option>Yaracuy</option>
                                    <option>Zulia</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="correo">Correo electronico:</label>
                            <input type="email" class="form-control" id="correo" name="correo" v-model="perfil.email"
                            :class="{ 'is-invalid': perfil.errors.has('email') }">
                            <has-error :form="perfil" field="email"></has-error>
                        </div>

                        <div class="form-group">
                            <label for="ci">Cédula de Identidad:</label>
                            <input type="number" class="form-control" name="ci" min="1000000" max="99999999" required v-model="perfil.ci"
                            :class="{ 'is-invalid': perfil.errors.has('ci') }">
                            <has-error :form="perfil" field="ci"></has-error>
                        </div>

                        <div class="form-group">
                            <label for="birth">Fecha de nacimiento:</label>
                            <input type="date" class="form-control" name="birth" v-model="perfil.birth"
                            :class="{ 'is-invalid': perfil.errors.has('birth') }">
                            <has-error :form="perfil" field="birth"></has-error>
                        </div>

                        <hr>

                        <div class="form-group row">
                            <label for="password" class="col-md-3 col-form-label">Cambiar contraseña:</label>

                            <div class="col-md-9">
                                <input id="password" type="password" class="form-control" name="password" autocomplete="new-password" v-model="perfil.clave">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="password-confirm" class="col-md-3 col-form-label">Repetir contraseña:</label>

                            <div class="col-md-9">
                                <input id="password-confirm" type="password" class="form-control" name="password_confirmation" autocomplete="new-password" v-model="perfil.clave_confirm">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success" style="width: 20%">Guardar</button>
                    <button type="button" @click="modoEditar = false" class="btn btn-secondary ml-3" style="width: 20%">Cancelar</button>
                </div>

            </div>
        </form>

        <form action="" v-else>
            <div class="col-md-10" style="margin: 0 auto">
                <div class="card card-body">
                    <div class="row align-items-center" style="min-width: 100%">
                        <div class="col-sm-6 col-md-4">
                            <img :src="getProfilePhoto()" alt="Avatar" class="rounded img-fluid">
                        </div>
                        <div class="col-sm-6 col-md-8">
                            <h4>{{ perfil.name }}</h4>
                            <small v-if="perfil.state != null"><cite>{{ perfil.city }}, {{ perfil.state }}</cite></small>
                            <p>{{ perfil.email }}<br>
                            <span v-if="perfil.ci != null">CI: {{ numberWithCommas(perfil.ci) }}</span><br>
                            <span v-if="perfil.birth != null">{{ perfil.birth }}</span></p>
                            <!-- Split button -->
                            <div class="btn-group">
                                <button @click="editPerfil()" class="btn btn-primary">Editar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</template>

<script>
    export default {
        data(){
            return {
                modoEditar: false,
                perfil: new Form({
                    id: '',
                    name: '',
                    clave: '',
                    clave_confirm: '',
                    email: '',
                    city: '',
                    state: '',
                    ci: '',
                    birth:'',
                    photo:''
                })
            }
        },
        mounted() {
            console.log('Component mounted.')
        },
        methods: {
            editPerfil(){
                this.modoEditar = true;
            },
            getProfilePhoto() {
                let prefix = (this.perfil.photo.match(/\//) ? '' : '/img/profile/');
                return prefix + this.perfil.photo;
            },
            updatePerfil(e){
                if( this.perfil.clave === this.perfil.clave_confirm){
                    this.modoEditar = false;
                    this.$Progress.start();
                    this.perfil.put('/profiles')
                    .then(() => {
                        this.$Progress.finish();
                    })
                    .catch(() => {
                        this.$Progress.fail();
                    });
                    Toast.fire({
                        icon: 'success',
                        title: 'Actualizado correctamente'
                    })
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: "Ups...",
                        text: "Las claves introducidas no coinciden",
                    });
                }
            },
            updateImg(e){
                let file = e.target.files[0];
                console.log(file);
                let reader = new FileReader();
                
                if(file['size'] < 2111775){
                    reader.onloadend = (file) => {
                        // console.log('RESULTADO', reader.result)
                        this.perfil.photo=reader.result;
                    }
                    reader.readAsDataURL(file);
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: "Ups...",
                        text: "El archivo excede el límite de peso (2mb)",
                    });
                }
            },
            numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
            }
        },

        created(){
            axios.get('profiles')
            .then(response => {
                this.perfil.id=response.data.id;
                this.perfil.name=response.data.name;
                this.perfil.email=response.data.email;
                this.perfil.city=response.data.city;
                this.perfil.state=response.data.state;
                this.perfil.ci=response.data.ci;
                this.perfil.birth=response.data.birth;
                this.perfil.photo=response.data.photo;
            })
            .catch(e => {
                console.log(e);
            });
        }
    }
</script>
