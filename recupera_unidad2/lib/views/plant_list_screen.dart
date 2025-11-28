import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/plant_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'plant_detail_screen.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({super.key});

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar las plantas al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlantViewModel>().loadPlants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guía de Plantas'),
        actions: [
          Consumer<ThemeViewModel>(
            builder: (context, themeViewModel, child) {
              return IconButton(
                icon: Icon(
                  themeViewModel.isDarkMode 
                    ? Icons.light_mode 
                    : Icons.dark_mode,
                ),
                onPressed: () {
                  themeViewModel.toggleTheme();
                },
                tooltip: themeViewModel.isDarkMode 
                  ? 'Cambiar a tema claro' 
                  : 'Cambiar a tema oscuro',
              );
            },
          ),
        ],
      ),
      body: Consumer<PlantViewModel>(
        builder: (context, plantViewModel, child) {
          if (plantViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (plantViewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    plantViewModel.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      plantViewModel.loadPlants();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (plantViewModel.plants.isEmpty) {
            return const Center(
              child: Text('No hay plantas disponibles'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: plantViewModel.plants.length,
            itemBuilder: (context, index) {
              final plant = plantViewModel.plants[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      plant.imagen,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.local_florist,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    plant.nombre,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  subtitle: Text(
                    plant.nombreCientifico,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailScreen(plant: plant),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
