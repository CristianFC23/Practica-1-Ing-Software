<template>
    <div class="page-container">
        <div class="dashboard-cards">
            <!-- Buscar Responsables Card -->
            <div class="card responsables-card">
                <div class="card-header">
                    <div class="card-icon responsables-icon">
                        <span>👥</span>
                    </div>
                    <div class="card-title">
                        <h3>Buscar Responsables</h3>
                        <p>Encuentra y gestiona los responsables registrados</p>
                    </div>
                </div>

                <!-- Input de búsqueda -->
                <div class="card-body">
                    <input 
                        type="text" 
                        v-model="searchQuery" 
                        placeholder="Ingrese nombre, documento, código o cargo"
                        class="search-input" 
                    />
                    <button 
                        @click="refrescarLista" 
                        class="refresh-btn"
                        :disabled="loading"
                    >
                        {{ loading ? 'Cargando...' : 'Refrescar' }}
                    </button>
                </div>

                <!-- Estado de carga -->
                <div v-if="loading" class="loading-state">
                    <p>Cargando responsables...</p>
                </div>

                <!-- Estado de error -->
                <div v-if="error" class="error-state">
                    <p>{{ error }}</p>
                    <button @click="refrescarLista" class="retry-btn">Reintentar</button>
                </div>

                <!-- Lista de resultados -->
                <div v-if="!loading && !error" class="card-body responsables-list">
                    <div v-if="responsablesFiltrados.length === 0" class="no-results">
                        <p>{{ searchQuery ? 'No se encontraron responsables que coincidan con la búsqueda' : 'No hay responsables registrados' }}</p>
                    </div>
                    
                    <div v-else>
                        <p class="results-count">
                            {{ responsablesFiltrados.length }} responsable(s) encontrado(s)
                        </p>
                        <div 
                            v-for="responsable in responsablesFiltrados" 
                            :key="responsable.id" 
                            class="responsable-item"
                        >
                            <div class="responsable-info">
                                <p class="responsable-nombre">{{ responsable.nombre }} {{ responsable.apellido }}</p>
                                <p class="responsable-detalle">
                                    <span class="badge cargo">{{ responsable.cargo }}</span>
                                </p>
                                <p class="responsable-contacto">
                                    📄 {{ responsable.documento }} | 🏷️ {{ responsable.codigo }}
                                </p>
                                <p class="responsable-telefono">
                                    📞 {{ responsable.telefono }}
                                </p>
                            </div>
                            <span class="responsable-arrow">➜</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            responsables: [],
            searchQuery: '',
            loading: false,
            error: null
        }
    },
    created: function () {
        this.consultarResponsables();
    },
    computed: {
        // Filtrar responsables según la búsqueda
        responsablesFiltrados() {
            if (!this.searchQuery) {
                return this.responsables;
            }
            
            const query = this.searchQuery.toLowerCase();
            return this.responsables.filter(responsable => 
                responsable.nombre.toLowerCase().includes(query) ||
                responsable.apellido.toLowerCase().includes(query) ||
                responsable.codigo.toLowerCase().includes(query) ||
                responsable.documento.includes(query) ||
                responsable.cargo.toLowerCase().includes(query) ||
                responsable.telefono.includes(query)
            );
        }
    },
    methods: {
        consultarResponsables() {
            this.loading = true;
            this.error = null;
            
            fetch('http://localhost/pacientes/responsables.php')
                .then(respuesta => {
                    if (!respuesta.ok) {
                        throw new Error('Error en la respuesta del servidor');
                    }
                    return respuesta.json();
                })
                .then((datosRespuesta) => {
                    console.log('Responsables cargados:', datosRespuesta);
                    
                    // Verificar si es un array válido
                    if (Array.isArray(datosRespuesta)) {
                        this.responsables = datosRespuesta;
                    } else {
                        console.error('Formato de respuesta inesperado:', datosRespuesta);
                        this.responsables = [];
                    }
                })
                .catch(error => {
                    console.error('Error al cargar responsables:', error);
                    this.error = 'Error al cargar los responsables';
                    this.responsables = [];
                })
                .finally(() => {
                    this.loading = false;
                });
        },
        
        // Método para buscar por código específico
        buscarPorCodigo(codigo) {
            if (!codigo) return;
            
            fetch(`http://localhost/pacientes/responsables.php?consultarCod=${encodeURIComponent(codigo)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Responsable encontrado:', datosRespuesta);
                    } else {
                        console.log('Responsable no encontrado');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para buscar por documento
        buscarPorDocumento(documento) {
            if (!documento) return;
            
            fetch(`http://localhost/pacientes/responsables.php?consultarDoc=${encodeURIComponent(documento)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Responsable encontrado:', datosRespuesta);
                    } else {
                        console.log('Responsable no encontrado');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para refrescar la lista
        refrescarLista() {
            this.consultarResponsables();
        }
    }
};
</script>

<style scoped>
/* Contenedor centrado */
.page-container {
    display: flex;
    justify-content: center;
    align-items: first baseline;
    min-height: 100vh;
    background: #f5f7fa;
    padding: 20px;
}

.dashboard-cards {
    display: grid;
    grid-template-columns: 1fr;
    max-width: 600px;
    width: 100%;
}

.card {
    background: white;
    border-radius: 16px;
    padding: 25px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    border: 1px solid #e8ecf0;
}

.card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

.card-header {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
}

.card-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    margin-right: 15px;
}

.responsables-icon {
    background: linear-gradient(135deg, #11998e, #38ef7d);
    color: white;
}

.card-title h3 {
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 5px 0;
    color: #2c3e50;
}

.card-title p {
    font-size: 14px;
    color: #7f8c8d;
    margin: 0;
    line-height: 1.4;
}

.card-body {
    margin-bottom: 20px;
}

/* Input de búsqueda y botones */
.search-input {
    width: 100%;
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.2s ease;
    margin-bottom: 10px;
}

.search-input:focus {
    border-color: #38ef7d;
    outline: none;
    box-shadow: 0 0 0 2px rgba(56, 239, 125, 0.3);
}

.refresh-btn, .retry-btn {
    padding: 8px 16px;
    border: 1px solid #11998e;
    border-radius: 6px;
    background: white;
    color: #11998e;
    cursor: pointer;
    font-size: 13px;
    transition: all 0.2s ease;
}

.refresh-btn:hover, .retry-btn:hover {
    background: #11998e;
    color: white;
}

.refresh-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

/* Estados de carga y error */
.loading-state, .error-state {
    text-align: center;
    padding: 20px;
    color: #7f8c8d;
}

.error-state {
    color: #e74c3c;
}

/* Lista de responsables */
.responsables-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.results-count {
    font-size: 12px;
    color: #11998e;
    margin-bottom: 15px;
    font-weight: 500;
}

.no-results {
    text-align: center;
    padding: 30px;
    color: #7f8c8d;
}

.responsable-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #f8f9fa;
    border-radius: 10px;
    padding: 15px;
    transition: all 0.3s ease;
    cursor: pointer;
    border-left: 4px solid #11998e;
}

.responsable-item:hover {
    background: #e9ecef;
    transform: translateX(5px);
}

.responsable-info {
    flex: 1;
}

.responsable-nombre {
    font-weight: 600;
    color: #2c3e50;
    margin: 0 0 8px 0;
    font-size: 16px;
}

.responsable-detalle {
    margin: 0 0 8px 0;
}

.badge {
    display: inline-block;
    padding: 3px 8px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: 500;
    text-transform: uppercase;
}

.cargo {
    background: #e8f5e8;
    color: #2d5f2d;
}

.responsable-contacto {
    font-size: 12px;
    color: #7f8c8d;
    margin: 0 0 5px 0;
}

.responsable-telefono {
    font-size: 12px;
    color: #11998e;
    margin: 0;
    font-weight: 500;
}

.responsable-arrow {
    font-size: 18px;
    color: #11998e;
    margin-left: 15px;
}
</style>