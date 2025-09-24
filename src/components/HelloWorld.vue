<template>
  <!-- Dashboard Cards -->
  <div class="dashboard-cards">
    <!-- Ubicaciones Card -->
    <div class="card ubicaciones-card">
      <div class="card-header">
        <div class="card-icon ubicaciones-icon">
          <span>📍</span>
        </div>
        <div class="card-title">
          <h3>Ubicaciones</h3>
          <p>Gestión de ubicaciones del centro médico</p>
        </div>
      </div>
      
      <div class="card-body">
        <div class="card-number">{{ ubicaciones.total }}</div>
        <div class="card-label">Total</div>
      </div>

      <div class="card-actions">
        <button class="btn btn-primary">
          <span class="btn-icon">+</span>
          Nueva Ubicación
        </button>
        <button class="btn btn-secondary">
          <span class="btn-icon">📋</span>
          Ver Todas
        </button>
      </div>
    </div>

    <!-- Responsables Card -->
    <div class="card responsables-card">
      <div class="card-header">
        <div class="card-icon responsables-icon">
          <span>👥</span>
        </div>
        <div class="card-title">
          <h3>Responsables</h3>
          <p>Personal responsable de equipos</p>
        </div>
      </div>
      
      <div class="card-body">
        <div class="card-number">{{ responsables.total }}</div>
        <div class="card-label">Total</div>
      </div>

      <div class="card-actions">
        <button class="btn btn-primary">
          <span class="btn-icon">+</span>
          Nuevo Responsable
        </button>
        <button class="btn btn-secondary">
          <span class="btn-icon">📋</span>
          Ver Todos
        </button>
      </div>
    </div>

    <!-- Equipos Médicos Card -->
    <div class="card equipos-card">
      <div class="card-header">
        <div class="card-icon equipos-icon">
          <span>🏥</span>
        </div>
        <div class="card-title">
          <h3>Equipos Médicos</h3>
          <p>Inventario de equipos médicos</p>
        </div>
      </div>
      
      <div class="card-body">
        <div class="card-number">{{ equipos.total }}</div>
        <div class="card-label">Total</div>
      </div>

      <div class="card-actions">
        <button class="btn btn-primary">
          <span class="btn-icon">+</span>
          Nuevo Equipo
        </button>
        <button class="btn btn-secondary">
          <span class="btn-icon">📋</span>
          Ver Todos
        </button>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  name: 'HospitalHome',
  data() {
    return {
      sidebarOpen: true,
      activeRoute: 'home',
      ubicaciones: {
        total: 15
      },
      responsables: {
        total: 28
      },
      equipos: {
        total: 142
      }
    }
  },
  methods: {
    toggleSidebar() {
      this.sidebarOpen = !this.sidebarOpen;
    },
    setActiveRoute(route) {
      this.activeRoute = route;
    }
  }
}
</script>

<style scoped>
  /* Dashboard Cards */
.dashboard-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
  max-width: 1200px;
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
  font-size: 20px;
  margin-right: 15px;
}

.ubicaciones-icon {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
}

.responsables-icon {
  background: linear-gradient(135deg, #11998e, #38ef7d);
  color: white;
}

.equipos-icon {
  background: linear-gradient(135deg, #fc7c7c, #ffb347);
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
  text-align: center;
  margin: 25px 0;
}

.card-number {
  font-size: 48px;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 8px;
}

.card-label {
  font-size: 14px;
  color: #7f8c8d;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.card-actions {
  display: flex;
  gap: 12px;
}

.btn {
  flex: 1;
  padding: 12px 16px;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.btn-primary {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
  background: #f8f9fa;
  color: #6c757d;
  border: 1px solid #dee2e6;
}

.btn-secondary:hover {
  background: #e9ecef;
  color: #495057;
}

.btn-icon {
  font-size: 12px;
}

/* Responsive Design */
@media (max-width: 768px) {
  .header {
    padding: 15px 20px;
    flex-direction: column;
    text-align: center;
    gap: 15px;
  }

  .header-right {
    text-align: center;
  }

  .company-name {
    font-size: 20px;
  }

  .sidebar {
    width: 70px;
  }

  .sidebar-collapsed {
    width: 70px;
  }

  .nav-text {
    display: none;
  }

  .main-content {
    padding: 40px 0 0 0;
  }

  .dashboard-cards {
    grid-template-columns: 1fr;
    gap: 20px;
  }

  .card-actions {
    flex-direction: column;
  }
}

@media (max-width: 480px) {
  .card {
    padding: 20px;
  }

  .card-number {
    font-size: 36px;
  }
}
</style>