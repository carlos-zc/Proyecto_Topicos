<style>
  div.dataTables_wrapper div.dataTables_filter {
    text-align: right;
  }
  div.dataTables_wrapper div.dataTables_filter label {
    font-weight: normal;
    white-space: nowrap;
    text-align: left;
  }
  div.dataTables_wrapper div.dataTables_filter input {
    margin-left: 0.5em;
    display: inline-block;
    width: auto;
  }
  div.dataTables_wrapper div.dataTables_paginate ul.pagination {
    margin: 2px 0;
    white-space: nowrap;
    justify-content: flex-end;
  }
  td {
    vertical-align: middle!important;
  }
</style>

<template>
<div class="card">
  <div class="card-header">
    <h3 class="card-title">Inmuebles</h3>
  </div>
  <!-- /.card-header -->
  <div class="card-body">
    <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <!-- <div class="dataTables_length" id="example1_length">
            <label>Show <select name="example1_length" aria-controls="example1" class="custom-select custom-select-sm form-control form-control-sm">
              <option value="10">10</option>
              <option value="25">25</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select> entries</label>
          </div> -->
          <button class="btn btn-success mb-3" @click="newModal"><i class="fas fa-plus mr-2"></i>Agregar Inmueble</button>
        </div>
        <div class="col-sm-12 col-md-6">
          <div id="example1_filter" class="dataTables_filter">
            <label>Buscar:<input type="search" class="form-control form-control-sm" placeholder="Buscar por ubicación..." aria-controls="example1" v-model="ubicacion"></label>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <table id="example1" class="table table-bordered table-striped table-responsive-sm dataTable" role="grid" aria-describedby="example1_info">
            <thead>
              <tr role="row">
                <th class="sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Id: activate to sort column descending">ID</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Nombre: activate to sort column ascending">Nombre</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Tipo: activate to sort column ascending">Tipo</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Ubicación: activate to sort column ascending">Ubicación</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Precio: activate to sort column ascending">Precio</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Foto: activate to sort column ascending">Foto</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Acciones: activate to sort column ascending">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr role="row" class="odd" v-for="item in searchVentas" :key="item.id">
                <td class="sorting_1">{{ item.id }}</td>
                <td>{{ item.nombre }}</td>
                <td>{{ item.tipo }}</td>
                <td>{{ item.municipio }}</td>
                <td>{{ numberWithCommas(item.precio) + '.00 $'}}</td>
                <td class="text-center">
                    <img :src="getFotoGuardada(item.foto)" alt="Venta" class="rounded img" style="max-height: 100px">
                </td>
                <td style="font-size: 20px" class="text-center">
                  <a href="#">
                    <i class="far fa-edit" @click="editModal(item)"></i>
                  </a>
                  <a href="#" @click="deleteVenta(item.id)">
                    <i class="fa fa-trash-alt text-danger ml-2"></i>
                  </a>
                </td>
              </tr>
            </tbody>
            <!-- <tfoot>
              <tr>
                <th rowspan="1" colspan="1">Id</th>
                <th rowspan="1" colspan="1">Nombre</th>
                <th rowspan="1" colspan="1">Apellido</th>
                <th rowspan="1" colspan="1">Cédula</th>
                <th rowspan="1" colspan="1">Acciones</th>
              </tr>
            </tfoot> -->
          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12 col-md-5">
          <!-- <div class="dataTables_info" id="example1_info" role="status" aria-live="polite">Mostrando de {{ pagination.current_page * pagination.per_page - 2 }} a {{ pagination.current_page * pagination.per_page }} de {{ pagination.total }}</div> -->
        </div>
        <div class="col-sm-12 col-md-7">
          <div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
            <ul class="pagination">
              <li class="paginate_button page-item previous" id="example1_previous" :class="{'disabled': pagination.current_page <= 1}">
                <a href="#" class="page-link" @click.prevent="changePage(pagination.current_page - 1)">Atras</a>
              </li>
              <li class="paginate_button page-item" v-for="page in pagesNumber" :key="page.current_page" :class="{ 'active': page == isActived }">
                <a href="#" class="page-link" @click.prevent="changePage(page)">{{ page }}</a>
              </li>
              <li class="paginate_button page-item next" id="example1_next" :class="{'disabled': pagination.current_page >= pagination.last_page}">
                <a href="#" class="page-link" @click.prevent="changePage(pagination.current_page + 1)">Siguiente</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div><!-- /.card-body -->
  
  <!-- Modal -->
<div class="modal fade" id="addVenta" tabindex="-1" role="dialog" aria-labelledby="addVentaLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" v-show="modoEditar" id="addVentaLabel">Editar Información del Inmueble</h5>
        <h5 class="modal-title" v-show="!modoEditar" id="addVentaLabel">Nuevo</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form @submit.prevent="modoEditar ? editVenta() : newVenta()">
        <div class="modal-body">
                <div class="form-group row">
                    <label for="nombre" class="col-sm-3 col-form-label">Nombre</label>
                    <div class="col-sm-9">
                        <input required type="text" class="form-control" name="nombre" placeholder="Nombre del inmueble" v-model="venta.nombre"
                        :class="{ 'is-invalid': venta.errors.has('nombre') }">
                        <has-error :form="venta" field="nombre"></has-error>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="tipo" class="col-sm-3 col-form-label">Tipo</label>
                    <div class="col-sm-9">
                        <select required class="form-control" name="tipo" v-model="venta.tipo"
                        :class="{ 'is-invalid': venta.errors.has('tipo') }">
                            <option disabled value="">Seleccionar una opción...</option>
                            <option>Casa</option>
                            <option>Apartamento</option>
                            <option>Townhouse</option>
                            <option>Quinta</option>
                        </select>
                        <has-error :form="venta" field="tipo"></has-error>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="municipio" class="col-sm-3 col-form-label">Municipio</label>
                    <div class="col-sm-9">
                        <select required class="form-control" name="municipio" v-model="venta.municipio"
                        :class="{ 'is-invalid': venta.errors.has('municipio') }">
                            <option disabled value="">Seleccionar una opción...</option>
                            <option>Bejuma</option>
                            <option>Carlos Arvelo</option>
                            <option>Diego Ibarra</option>
                            <option>Guacara</option>
                            <option>Juan José Mora</option>
                            <option>Libertador</option>
                            <option>Los Guayos</option>
                            <option>Miranda</option>
                            <option>Montalbán</option>
                            <option>Naguanagua</option>
                            <option>Puerto Cabello</option>
                            <option>San Diego</option>
                            <option>San Joaquín</option>
                            <option>Valencia</option>
                        </select>
                        <has-error :form="venta" field="municipio"></has-error>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="precio" class="col-sm-3 col-form-label">Precio ($)</label>
                    <div class="col-sm-9">
                        <input required type="number" class="form-control" name="precio" min="1" placeholder="Precio en $" v-model="venta.precio"
                        :class="{ 'is-invalid': venta.errors.has('precio') }">
                        <has-error :form="venta" field="precio"></has-error>
                    </div>
                </div>

                <div>
                    <div class="text-center">
                        <img :src="getVentaFoto()" alt="Venta" class="rounded img-fluid" style="max-height: 200px">
                    </div>
                    <p class="mt-4">Seleccionar Imagen<span class="font-weight-bold">(Máx. 2 Mb)</span></p>
                    <div class="form-group">
                        <input type="file" name="adjunto" @change="updateImg" class="form-control-file" accept=".jpg,.png">
                    </div>
                </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
            <button v-show="modoEditar" type="submit" class="btn btn-success">Guardar</button>
            <button v-show="!modoEditar" type="submit" class="btn btn-primary">Agregar</button>
        </div>
        </form>
    </div>
  </div>
</div> <!-- Modal -->

</div><!-- /.card -->


</template>

<script>
    export default {
        data(){
            return {
                ventas: [],
                venta: new Form({
                    id: '',
                    nombre: '',
                    tipo: '',
                    precio: '',
                    descripcion: '',
                    municipio: '',
                    foto: ''
                }),
                ubicacion: '',
                modoEditar: false,
                pagination: {
                    'total': 0,
                    'current_page': 1,
                    'per_page': 0,
                    'last_page': 0,
                    'from': 0,
                    'to': 0,
                },
                offset: 2
            }
        },
        computed: {
            isActived(){
                return this.pagination.current_page;
            },

            pagesNumber(){
                if(!this.pagination.to){
                return [];
                }

                let from = this.pagination.current_page - this.offset;
                if(from < 1){
                from = 1;
                }

                let to = from + (this.offset * 2);
                if (to>= this.pagination.last_page){
                to = this.pagination.last_page;
                }

                let pagesArray = [];
                while(from <= to){
                pagesArray.push(from);
                from++;
                }

                return pagesArray;
            },

            searchVentas(){
                return this.ventas.filter(item => item.municipio.toLowerCase().includes(this.ubicacion.toLowerCase()));
            }
        },
        methods: {
            newVenta(){
                this.venta.post('venta');
                Fire.$emit('AfterCreate');
                
                $('#addVenta').modal('hide');
            },

            editVenta(){
                this.$Progress.start();
                this.venta.put('venta/'+this.venta.id)
                .then(() => {
                    this.$Progress.finish();
                    Fire.$emit('AfterCreate');
                })
                .catch(() => {
                    this.$Progress.fail();
                });
                Toast.fire({
                    icon: 'success',
                    title: 'Actualizado correctamente'
                })
                
                $('#addVenta').modal('hide');
            },

            editModal(venta){
                this.modoEditar = true;
                this.venta.reset();
                $('#addVenta').modal('show');
                this.venta.fill(venta);
            },

            newModal(){
                this.modoEditar = false;
                this.venta.reset();
                $('#addVenta').modal('show');
            },

            loadVentas(page){
                // axios.get("/users").then(({ data }) => this.users = data.data);
                axios.get('venta?page='+page).then(response => {
                    this.ventas = response.data.ventas.data,
                    this.pagination = response.data.pagination
                })
            },

            deleteVenta(id){
                Swal.fire({
                title: '¿Seguro que desea borrar este Inmueble?',
                text: "Esta acción no podrá ser revertida",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Si, Borrar'
                }).then((result) => {

                if (result.value) {
                    this.venta.delete('venta/'+id).then(() => {
                        Swal.fire(
                            'Eliminado',
                            'Inmueble eliminado correctamente',
                            'success'
                        )
                        Fire.$emit('AfterCreate');
                        }).catch(() => {
                            Swal.fire('Error','Algo ha salido mal...','warning');
                        })
                    }
                })
            },

            getVentaFoto() {
                if(this.venta.foto == ''){
                    return "img/inmueble/ejemplo.png";
                }else{
                    let prefix = (this.venta.foto.match(/\//) ? '' : '/img/inmueble/');
                    return prefix + this.venta.foto;
                }
            },

            getFotoGuardada(img) {
                return "img/inmueble/" + img;
            },

            updateImg(e){
                let file = e.target.files[0];
                console.log(file);
                let reader = new FileReader();
                
                if(file['size'] < 2111775){
                    reader.onloadend = (file) => {
                        // console.log('RESULTADO', reader.result)
                        this.venta.foto=reader.result;
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

            changePage(page){
                this.pagination.current_page = page;
                this.loadVentas(page);
            },

            numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            },
        },
        created() {
            let page = this.pagination.current_page;
            this.loadVentas(page);
            Fire.$on('AfterCreate', () => {
                this.loadVentas(page);
            });
        }
    }
</script>
