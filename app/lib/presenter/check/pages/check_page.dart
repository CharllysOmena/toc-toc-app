import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/services/camera_service.dart';
import '../../../domain/entities/checklist_item.dart';
import '../../../domain/entities/day_time.dart';
import '../../../domain/entities/monitored_object.dart';
import '../../shared/colors.dart';
import '../../shared/widgets/app_cta.dart';
import '../../shared/widgets/confirm_stamp.dart';
import '../bloc/check_bloc.dart';
import '../bloc/check_event.dart';
import '../bloc/check_state.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key, required this.itemId});

  final String itemId;

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  late final CameraService _cameraService;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _cameraService = GetIt.I<CameraService>();
    // ignore: discarded_futures
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      await _cameraService.initialize();
      if (mounted) setState(() => _cameraInitialized = true);
    } catch (_) {
      if (mounted) setState(() => _cameraInitialized = false);
    }
  }

  @override
  void dispose() {
    // ignore: discarded_futures
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.panel,
      appBar: AppBar(
        title: const Text('Registrar'),
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.ink,
        iconTheme: const IconThemeData(color: AppColors.ink, size: 24),
        titleTextStyle: const TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => context.go('/checklist'),
        ),
      ),
      body: BlocBuilder<CheckBloc, CheckState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.confirm),
            ),
            ready: (item) {
              final object = MonitoredObjects.byId(item.objectId);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${object.emoji} ${object.label} • ${item.time.format()}',
                          style: const TextStyle(
                            color: AppColors.inkSoft,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: _cameraInitialized
                                  ? _cameraService.buildPreview()
                                  : Container(color: const Color(0xFFE4E7DD)),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.line),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      child: AppCta(
                        label: 'Registrar',
                        onPressed: () async {
                          // ignore: discarded_futures
                          final photo = await _cameraService.takePicture();
                          if (context.mounted) {
                            context.read<CheckBloc>().add(
                              CheckEvent.captureRequested(photo?.path),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            processing: (item) => const Center(
              child: CircularProgressIndicator(color: AppColors.confirm),
            ),
            confirmed: (result) {
              final time = DateFormat('HH:mm').format(result.timestamp);
              final hasPhoto =
                  result.photoPath != null &&
                  File(result.photoPath!).existsSync();
              final stampLabel = result.manual
                  ? '$time · ${result.item.title} confirmado manualmente'
                  : '$time · ${result.item.title} registrado';
              return Column(
                children: [
                  Expanded(
                    child: Center(child: ConfirmStamp(timeLabel: stampLabel)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: StreakBanner(
                      text: result.manual
                          ? 'Confirmado manualmente'
                          : 'Registrado com sucesso',
                    ),
                  ),
                  if (hasPhoto)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // ignore: discarded_futures
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(result.photoPath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.photo_outlined, size: 18),
                          label: const Text('Ver foto'),
                        ),
                      ),
                    ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: AppGhostButton(
                        label: 'Ver histórico',
                        onPressed: () =>
                            context.go('/history/${result.item.id}'),
                      ),
                    ),
                  ),
                ],
              );
            },
            missing: (result) {
              final object = MonitoredObjects.byId(result.item.objectId);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.alertBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '${object.label} não detectado',
                        style: const TextStyle(
                          color: AppColors.alert,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${object.emoji} ${object.label}',
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          const AppCtaSub(
                            text: 'A IA não encontrou o item na foto. Se ele está aí, você pode confirmar manualmente.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSecondaryButton(
                            label: 'Tentar novamente',
                            onPressed: () => context.read<CheckBloc>().add(
                              const CheckEvent.started(),
                            ),
                          ),
                          AppGhostButton(
                            label: 'Confirmar manualmente',
                            onPressed: () => context.read<CheckBloc>().add(
                              const CheckEvent.manualConfirmed(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            unavailable: (item, message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: AppColors.inkSoft,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.inkSoft),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.windowLabel(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.inkSoft,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppSecondaryButton(
                      label: 'Voltar',
                      onPressed: () => context.go('/checklist'),
                    ),
                  ],
                ),
              ),
            ),
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.alert,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(message, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
