<template>
    <div class="page-container">
        <div class="dashboard-cards">
            <!-- Buscar Ubicaciones Card -->
            <div class="card ubicaciones-card">
                <div class="card-header">
                    <div class="card-icon ubicaciones-icon">
                        <span>📍</span>
                    </div>
                    <div class="card-title">
                        <h3>Buscar Ubicaciones</h3>
                        <p>Encuentra y gestiona las ubicaciones registradas</p>
                    </div>
                </div>

                <!-- Input de búsqueda -->
                <div class="card-body">
                    <input 
                        type="text" 
                        v-model="searchQuery" 
                        placeholder="Ingrese nombre, área o código de la ubicación"
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
                    <p>Cargando ubicaciones...</p>
                </div>

                <!-- Estado de error -->
                <div v-if="error" class="error-state">
                    <p>{{ error }}</p>
                    <button @click="refrescarLista" class="retry-btn">Reintentar</button>
                </div>

                <!-- Lista de resultados -->
                <div v-if="!loading && !error" class="card-body ubicaciones-list">
                    <div v-if="ubicacionesFiltradas.length === 0" class="no-results">
                        <p>{{ searchQuery ? 'No se encontraron ubicaciones que coincidan con la búsqueda' : 'No hay ubicaciones registradas' }}</p>
                    </div>
                    
                    <div v-else>
                        <p class="results-count">
                            {{ ubicacionesFiltradas.length }} ubicación(es) encontrada(s)
                        </p>
                        <div 
                            v-for="ubicacion in ubicacionesFiltradas" 
                            :key="ubicacion.id" 
                            class="ubicacion-item"
                        >
                            <div class="ubicacion-info">
                                <p class="ubicacion-nombre">{{ ubicacion.nombre }}</p>
                                <p class="ubicacion-detalle">
                                    Código: {{ ubicacion.codigo }} – {{ ubicacion.ubicacion }}
                                </p>
                                <p class="ubicacion-telefono">
                                    📞 {{ ubicacion.telefono }}
                                </p>
                            </div>
                            <span class="ubicacion-arrow">➜</span>
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
            ubicaciones: [],
            searchQuery: '',
            loading: false,
            error: null
        }
    },
    created: function () {
        this.consultarUbicaciones();
    },
    computed: {
        // Filtrar ubicaciones según la búsqueda
        ubicacionesFiltradas() {
            if (!this.searchQuery) {
                return this.ubicaciones;
            }
            
            const query = this.searchQuery.toLowerCase();
            return this.ubicaciones.filter(ubicacion => 
                ubicacion.nombre.toLowerCase().includes(query) ||
                ubicacion.codigo.toLowerCase().includes(query) ||
                ubicacion.ubicacion.toLowerCase().includes(query) ||
                ubicacion.telefono.includes(query)
            );
        }
    },
    methods: {
        consultarUbicaciones() {
            this.loading = true;
            this.error = null;
            
            fetch('http://localhost/pacientes/ubicaciones.php')
                .then(respuesta => {
                    if (!respuesta.ok) {
                        throw new Error('Error en la respuesta del servidor');
                    }
                    return respuesta.json();
                })
                .then((datosRespuesta) => {
                    console.log('Ubicaciones cargadas:', datosRespuesta);
                    
                    // Verificar si es un array válido
                    if (Array.isArray(datosRespuesta)) {
                        this.ubicaciones = datosRespuesta;
                    } else {
                        console.error('Formato de respuesta inesperado:', datosRespuesta);
                        this.ubicaciones = [];
                    }
                })
                .catch(error => {
                    console.error('Error al cargar ubicaciones:', error);
                    this.error = 'Error al cargar las ubicaciones';
                    this.ubicaciones = [];
                })
                .finally(() => {
                    this.loading = false;
                });
        },
        
        // Método para buscar por código específico
        buscarPorCodigo(codigo) {
            if (!codigo) return;
            
            fetch(`http://localhost/pacientes/ubicaciones.php?consultarCod=${encodeURIComponent(codigo)}`)
                .then(respuesta => respuesta.json())
                .then((datosRespuesta) => {
                    if (datosRespuesta.success !== 0) {
                        console.log('Ubicación encontrada:', datosRespuesta);
                        // Aquí puedes hacer algo específico con la ubicación encontrada
                    } else {
                        console.log('Ubicación no encontrada');
                    }
                })
                .catch(error => {
                    console.error('Error en búsqueda:', error);
                });
        },
        
        // Método para refrescar la lista
        refrescarLista() {
            this.consultarUbicaciones();
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

/* Reutilizando estilo de las cards */
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

.ubicaciones-icon {
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

/* Lista de ubicaciones */
.ubicaciones-list {
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

.ubicacion-item {
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

.ubicacion-item:hover {
    background: #e9ecef;
    transform: translateX(5px);
}

.ubicacion-info {
    flex: 1;
}

.ubicacion-nombre {
    font-weight: 600;
    color: #2c3e50;
    margin: 0 0 5px 0;
    font-size: 16px;
}

.ubicacion-detalle {
    font-size: 13px;
    color: #7f8c8d;
    margin: 0 0 5px 0;
}

.ubicacion-telefono {
    font-size: 12px;
    color: #667eea;
    margin: 0;
    font-weight: 500;
}

.ubicacion-arrow {
    font-size: 18px;
    color: #667eea;
    margin-left: 15px;
}
</style>