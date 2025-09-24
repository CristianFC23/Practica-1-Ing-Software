<template>
    <div class="page-container">
        <div class="dashboard-cards">
            <!-- Buscar Encargados Card -->
            <div class="card encargados-card">
                <div class="card-header">
                    <div class="card-icon encargados-icon">
                        <span>📍</span>
                    </div>
                    <div class="card-title">
                        <h3>Buscar Ubicaciones</h3>
                        <p>Encuentra y gestiona las ubicaciones registrados</p>
                    </div>
                </div>

                <!-- Input de búsqueda -->
                <div class="card-body">
                    <input type="text" v-model="searchQuery"
                        placeholder="Ingrese nombre, area o código de la ubicación" class="search-input" />
                </div>

                <!-- Lista de resultados -->
                <div class="card-body encargados-list">
                    <div v-for="encargado in filteredEncargados" :key="encargado.codigo" class="encargado-item">
                        <div>
                            <p class="encargado-nombre">{{ encargado.nombre }}</p>
                            <p class="encargado-detalle">
                                Código: {{ encargado.codigo }} – {{ encargado.cargo }} – {{ encargado.telefono }}
                            </p>
                        </div>
                        <span class="encargado-arrow">➜</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "BuscarEncargados",
    data() {
        return {
            searchQuery: "",
            encargados: [
                {
                    nombre: "Dr. Juan Pérez",
                    codigo: 456,
                    cargo: "Especialista",
                    telefono: "+57 300 123 4567",
                },
                {
                    nombre: "Enf. María Gómez",
                    codigo: 457,
                    cargo: "Enfermera",
                    telefono: "+57 310 555 7890",
                },
                {
                    nombre: "Tec. Carlos Ruiz",
                    codigo: 458,
                    cargo: "Técnico",
                    telefono: "+57 320 999 8888",
                },
            ],
        };
    },
    computed: {
        filteredEncargados() {
            if (!this.searchQuery) return this.encargados;
            const q = this.searchQuery.toLowerCase();
            return this.encargados.filter(
                (e) =>
                    e.nombre.toLowerCase().includes(q) ||
                    e.codigo.toString().includes(q) ||
                    e.telefono.includes(q)
            );
        },
    },
};
</script>

<style scoped>
/* Contenedor centrado */
.page-container {
    display: flex;
    justify-content: center;
    align-items:first baseline;
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

.encargados-icon {
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

/* Input de búsqueda */
.search-input {
    width: 100%;
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.2s ease;
}

.search-input:focus {
    border-color: #38ef7d;
    outline: none;
    box-shadow: 0 0 0 2px rgba(56, 239, 125, 0.3);
}

/* Lista de encargados */
.encargados-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.encargado-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #f8f9fa;
    border-radius: 10px;
    padding: 12px 16px;
    transition: background 0.3s ease;
    cursor: pointer;
}

.encargado-item:hover {
    background: #e9ecef;
}

.encargado-nombre {
    font-weight: 600;
    color: #2c3e50;
}

.encargado-detalle {
    font-size: 13px;
    color: #7f8c8d;
}

.encargado-arrow {
    font-size: 16px;
    color: #6c757d;
}
</style>
