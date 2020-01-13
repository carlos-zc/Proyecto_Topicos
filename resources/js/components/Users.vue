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
</style>

<template>
<div class="card">
  <div class="card-header">
    <h3 class="card-title">Usuarios Registrados</h3>
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
        </div>
        <div class="col-sm-12 col-md-6">
          <div id="example1_filter" class="dataTables_filter">
            <label>Buscar:<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="example1" v-model="ci"></label>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <table id="example1" class="table table-bordered table-striped dataTable" role="grid" aria-describedby="example1_info">
            <thead>
              <tr role="row">
                <th class="sorting_asc" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Id: activate to sort column descending" style="width: 106px;">ID</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Nombre: activate to sort column ascending" style="width: 423px;">Nombre y Apellido</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Cédula: activate to sort column ascending" style="width: 199px;">Cédula</th>
                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Acciones: activate to sort column ascending" style="width: 99px;">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr role="row" class="odd" v-for="item in searchUsers" :key="item.id">
                <td class="sorting_1">{{ item.id }}</td>
                <td>{{ item.name }}</td>
                <td v-if="item.ci != null">{{ numberWithCommas(item.ci) }}</td>
                <td v-else>{{ item.ci }}</td>
                <td style="font-size: 20px">
                  <a href="#" @click="updateEstadoActivo(item.active, item.id)">
                    <i class="fas" :class="{'fa-toggle-on text-success': item.active ,'fa-toggle-off text-secondary' : !item.active}" style="transition: all 0.8s" ></i>
                  </a>
                  <a href="#" @click="deleteUser(item.id)">
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
  </div>
  <!-- /.card-body -->
</div>
<!-- /.card -->
</template>

<script>
  export default {
    data (){
      return {
          users: [],
          user: new Form({
            id: '',
            name: '',
            ci: '',
            active: ''
        }),
        ci: '',
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

      searchUsers(){
        return this.users.filter(item => item.ci.includes(this.ci));
      }
    },
    methods: {
      loadUsers(page){
          // axios.get("/users").then(({ data }) => this.users = data.data);
          axios.get('api/user?page='+page).then(response => {
            this.users = response.data.usuarios.data,
            this.pagination = response.data.pagination
          })
      },

      deleteUser(id){
        Swal.fire({
          title: '¿Seguro que desea eliminarlo?',
          text: "Esta acción no podrá ser revertida",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Si, Borrar'
        }).then((result) => {

          if (result.value) {
            this.user.delete('api/user/'+id).then(() => {
              Swal.fire(
                'Eliminado',
                'Usuario eliminado correctamente',
                'success'
              )
              Fire.$emit('AfterCreate');
            }).catch(() => {
              Swal.fire('Error','Algo ha salido mal...','warning');
            })
          }
        })
      },

      updateEstadoActivo(estado, id){
        
        this.user.active = !estado;

        this.user.put('api/user/'+id).then(() => {
          Fire.$emit('AfterCreate');
        }).catch(() => {
          Swal.fire('Error','Algo ha salido mal...','warning');
        })
      },

      numberWithCommas(x) {
          return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
      },

      changePage(page){
        this.pagination.current_page = page;
        this.loadUsers(page);
      }
    },
    created() {
      let page = this.pagination.current_page;
      this.loadUsers(page);
      Fire.$on('AfterCreate', () => {
        this.loadUsers(page);
      });
    }
}
</script>