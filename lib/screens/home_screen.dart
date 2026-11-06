import 'package:flutter/material.dart';
import '../models/producto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categorias = [
    'Todos',
    'Hardware',
    'Procesadores',
    'Almacenamiento',
    'Periféricos',
  ];

  String _categoriaSeleccionada = 'Todos';
  String _busqueda = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Producto> _productos = [
    const Producto(
      nombre: 'Intel Core i9-13900K',
      categoria: 'Procesadores',
      precio: 2199.90,
      descripcion:
          'Procesador de alto rendimiento con 24 núcleos (8P+16E) y frecuencia máxima de 5.8 GHz. Ideal para workstations y laboratorios de TI de alto rendimiento.',
    ),
    const Producto(
      nombre: 'SSD Samsung 970 EVO 1TB',
      categoria: 'Almacenamiento',
      precio: 459.00,
      descripcion:
          'Unidad de estado sólido NVMe M.2 con velocidades de lectura de hasta 3,500 MB/s. Perfecta para sistemas de arranque y almacenamiento rápido en laboratorios.',
    ),
    const Producto(
      nombre: 'Parlantes Profesionales',
      categoria: 'Periféricos',
      precio: 320.00,
      descripcion:
          'Parlantes profesionales con calidad de audio Bluetooth 5.0, potencia de 60W RMS y respuesta de frecuencia de 20Hz a 20kHz. Uso en aulas y laboratorios.',
    ),
    const Producto(
      nombre: 'Tarjeta Gráfica RTX 4060',
      categoria: 'Hardware',
      precio: 1850.00,
      descripcion:
          'GPU NVIDIA GeForce RTX 4060 con 8GB GDDR6, soporte para Ray Tracing y DLSS 3. Óptima para renderizado y diseño gráfico en estaciones de trabajo.',
    ),
    const Producto(
      nombre: 'Monitor Dell 27" 4K',
      categoria: 'Periféricos',
      precio: 1250.00,
      descripcion:
          'Monitor UHD 4K IPS de 27 pulgadas con tiempo de respuesta de 5ms, 60Hz y cobertura del 99% del espacio de color sRGB. Ideal para diseño y desarrollo.',
    ),
    const Producto(
      nombre: 'RAM Corsair 32GB DDR5',
      categoria: 'Hardware',
      precio: 680.00,
      descripcion:
          'Kit de memoria RAM DDR5 32GB (2x16GB) a 5200MHz con disipador XMP 3.0. Compatible con plataformas Intel 12/13 Gen para máximo rendimiento multitarea.',
    ),
  ];

  List<Producto> get _productosFiltrados {
    final query = _busqueda.trim().toLowerCase();
    return _productos.where((p) {
      final coincideCategoria =
          _categoriaSeleccionada == 'Todos' ||
          p.categoria.toLowerCase() == _categoriaSeleccionada.toLowerCase();
      final coincideBusqueda =
          query.isEmpty ||
          p.nombre.toLowerCase().contains(query) ||
          p.categoria.toLowerCase().contains(query) ||
          p.descripcion.toLowerCase().contains(query);
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  Color _colorCategoria(String categoria) {
    switch (categoria) {
      case 'Procesadores':
        return Colors.orange;
      case 'Almacenamiento':
        return Colors.blue;
      case 'Periféricos':
        return Colors.purple;
      case 'Hardware':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _mostrarFormulario() {
    final formKey = GlobalKey<FormState>();
    final nombreCtrl = TextEditingController();
    final precioCtrl = TextEditingController();
    final descripcionCtrl = TextEditingController();
    String? categoriaSeleccionada;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.add_box, color: Color(0xFF003399)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Nuevo Componente',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          actionsOverflowButtonSpacing: 8,
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Componente',
                        prefixIcon: Icon(Icons.computer),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Campo requerido' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: ['Hardware', 'Procesadores', 'Almacenamiento', 'Periféricos']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) => categoriaSeleccionada = v,
                      validator: (v) => v == null ? 'Selecciona una categoría' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: precioCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        prefixIcon: Icon(Icons.attach_money),
                        hintText: 'Ej. S/ 450.00',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Campo requerido';
                        if (double.tryParse(v) == null) return 'Ingresa un número válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descripcionCtrl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Descripción Técnica',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Campo requerido' : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003399),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.save),
              label: const Text('Guardar Componente'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    _productos.add(Producto(
                      nombre: nombreCtrl.text.trim(),
                      categoria: categoriaSeleccionada!,
                      precio: double.parse(precioCtrl.text.trim()),
                      descripcion: descripcionCtrl.text.trim(),
                    ));
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Componente guardado exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtrados = _productosFiltrados;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003399),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo_senati.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.school,
                  color: Color(0xFF003399),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Catálogo SENATI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar Sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _busqueda = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar componente...',
                hintStyle: const TextStyle(color: Colors.white60),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: _busqueda.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _busqueda = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white24,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Barra de chips de filtro
          SizedBox(
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categorias.length,
              itemBuilder: (_, i) {
                final cat = _categorias[i];
                final seleccionado = cat == _categoriaSeleccionada;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: seleccionado,
                    onSelected: (_) =>
                        setState(() => _categoriaSeleccionada = cat),
                    selectedColor: const Color(0xFF003399),
                    labelStyle: TextStyle(
                      color: seleccionado ? Colors.white : Colors.black87,
                      fontWeight: seleccionado
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    checkmarkColor: Colors.white,
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Lista de productos
          Expanded(
            child: filtrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'No se encontraron componentes',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtrados.length,
                    itemBuilder: (_, i) {
                      final p = filtrados[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor:
                                _colorCategoria(p.categoria).withValues(alpha: 0.15),
                            child: Icon(
                              Icons.memory,
                              color: _colorCategoria(p.categoria),
                            ),
                          ),
                          title: Text(
                            p.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _colorCategoria(p.categoria)
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  p.categoria,
                                  style: TextStyle(
                                    color: _colorCategoria(p.categoria),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'S/. ${p.precio.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Color(0xFF003399),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: p,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarFormulario,
        backgroundColor: const Color(0xFF003399),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Componente'),
      ),
    );
  }
}
