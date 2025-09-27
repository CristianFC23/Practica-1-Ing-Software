<template>
    <div class="page-container">
        <div class="dashboard-cards">
            <!-- Buscar Equipos Médicos Card -->
            <div class="card equipos-card">
                <div class="card-header">
                    <div class="card-icon equipos-icon">
                        <span>🏥</span>
                    </div>
                    <div class="card-title">
                        <h3>Buscar Equipos Médicos</h3>
                        <p>Encuentra y gestiona los equipos médicos registrados</p>
                    </div>
                </div>

                <!-- Input de búsqueda -->
                <div class="card-body">
                    <input 
                        type="text" 
                        v-model="searchQuery" 
                        placeholder="Ingrese código, marca, modelo, ubicación o responsable"
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
                    <p>Cargando equipos médicos...</p>
                </div>

                <!-- Estado de error -->
                <div v-if="error" class="error-state">
                    <p>{{ error }}</p>
                    <button @click="refrescarLista" class="retry-btn">Reintentar</button>
                </div>

                <!-- Lista de resultados -->
                <div v-if="!loading && !error" class="card-body equipos-list">
                    <div v-if="equiposFiltrados.length === 0" class="no-results">
                        <p>{{ searchQuery ? 'No se encontraron equipos médicos que coincidan con la búsqueda' : 'No hay equipos médicos registrados' }}</p>
                    </div>
                    
                    <div v-else>
                        <p class="results-count">
                            {{ equiposFiltrados.length }} equipo(s) médico(s) encontrado(s)
                        </p>
                        <div 
                            v-for="equipo in equiposFiltrados" 
                            :key="equipo.id" 
                            class="equipo-item"
                        >
                            <div class="equipo-info">
                                <p class="equipo-marca-modelo">{{ equipo.marca }} {{ equipo.modelo }}</p>
                                <p class="equipo-codigo">
                                    <span class="badge codigo">{{ equipo.codigo }}</span>
                                </p>
                                <p class="equipo-ubicacion">
                                    📍 {{ equipo.ubicacion }}
                                </p>
                                <p class="equipo-responsable">
                                    👤 {{ equipo.responsable }}
                                </p>
                            </div>
                            <span class="equipo-arrow">➜</span>
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
            equipos: [],
            searchQuery: '',
            loading: false,
            error: null
        }
    },
    created: function () {
        this.consultarEquipos();
    },
    computed: {
        // Filtrar equipos según la búsqueda
        equiposFiltrados() {
            if (!this.searchQuery) {
                return this.equipos;
            }
            
            const query = this.searchQuery.toLowerCase();
            return this.equipos.filter(equipo => 
                equipo.codigo.toLowerCase().includes(query) ||
                equipo.marca.toLowerCase().includes(query) ||
                equipo.modelo.toLowerCase().includes(query) ||
                equipo.ubicacion.toLowerCase().includes(query) ||
                equipo.responsable.toLowerCase().includes(query)
            );
        }
    },
    methods: {
        consultarEquipos() {
            this.loading = true;
            this.error = null;
            
            fetch('http://localhost/pacientes/equipos_medicos.php')
                .then(respuesta => {
                    if (!respuesta.ok) {
                        throw new Error('Error en la respuesta del servidor');
                    }
                    return respuesta.json();
                })
                .then((datosRespuesta) => {
                    console.log('Equipos médicos cargados:', datosRespuesta);
                    
                    // Verificar si es un array válido
                    if (Array.isArray(datosRespuesta)) {
                        this.equipos = datosRespuesta;
                    } else {
                        console.error('Formato de respuesta inesperado:', datosRespuesta);
                        this.equipos = [];
                    }
                })
                .catch(error => {
                    console.error('Error al cargar equipos médicos:', error);
                    this.error = 'Error al cargar los equipos médicos';
                    this.equipos = [];
                })
                .finally(() => {
                    this.loading = false;
                });
        },
        
        // Método para buscar por código específico
        buscarPorCodigo(codigo) {
            if (!codigo) return;
            
            fetch(`http://localhost/pacientes/equipos_medicos.php?consultarCod=${encodeURIComponent(codigo)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Equipo encontrado:', datosRespuesta);
                    } else {
                        console.log('Equipo no encontrado');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para buscar por ubicación
        buscarPorUbicacion(ubicacion) {
            if (!ubicacion) return;
            
            fetch(`http://localhost/pacientes/equipos_medicos.php?consultarUbicacion=${encodeURIComponent(ubicacion)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Equipos encontrados:', datosRespuesta);
                    } else {
                        console.log('No se encontraron equipos en esa ubicación');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para buscar por responsable
        buscarPorResponsable(responsable) {
            if (!responsable) return;
            
            fetch(`http://localhost/pacientes/equipos_medicos.php?consultarResponsable=${encodeURIComponent(responsable)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Equipos encontrados:', datosRespuesta);
                    } else {
                        console.log('No se encontraron equipos para ese responsable');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para refrescar la lista
        refrescarLista() {
            this.consultarEquipos();
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

.equipos-icon {
    background: linear-gradient(135deg, #667eea, #764ba2);
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
    border-color: #667eea;
    outline: none;
    box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.3);
}

.refresh-btn, .retry-btn {
    padding: 8px 16px;
    border: 1px solid #667eea;
    border-radius: 6px;
    background: white;
    color: #667eea;
    cursor: pointer;
    font-size: 13px;
    transition: all 0.2s ease;
}

.refresh-btn:hover, .retry-btn:hover {
    background: #667eea;
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

/* Lista de equipos médicos */
.equipos-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.results-count {
    font-size: 12px;
    color: #667eea;
    margin-bottom: 15px;
    font-weight: 500;
}

.no-results {
    text-align: center;
    padding: 30px;
    color: #7f8c8d;
}

.equipo-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #f8f9fa;
    border-radius: 10px;
    padding: 15px;
    transition: all 0.3s ease;
    cursor: pointer;
    border-left: 4px solid #667eea;
}

.equipo-item:hover {
    background: #e9ecef;
    transform: translateX(5px);
}

.equipo-info {
    flex: 1;
}

.equipo-marca-modelo {
    font-weight: 600;
    color: #2c3e50;
    margin: 0 0 8px 0;
    font-size: 16px;
}

.equipo-codigo {
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

.codigo {
    background: #e3f2fd;
    color: #1976d2;
}

.equipo-ubicacion {
    font-size: 12px;
    color: #7f8c8d;
    margin: 0 0 5px 0;
}

.equipo-responsable {
    font-size: 12px;
    color: #667eea;
    margin: 0;
    font-weight: 500;
}

.equipo-arrow {
    font-size: 18px;
    color: #667eea;
    margin-left: 15px;
}
</style>