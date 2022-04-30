import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/widgets/input_field.dart';
import 'package:myarchapp/features/weather/models/city_weather.dart';
import 'package:myarchapp/features/weather/providers/weather_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.weatherHeader),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: AppInputField(
                  hint: 'Enter city',
                  controller: ref.read(weatherProvider.notifier).cityController,
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(weatherProvider.notifier).started();
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: weatherState.when(
                data: (weather) {
                  if (weather.city.isEmpty) {
                    return const Text('Search city...');
                  }
                  return _WeatherInfo(weather);
                },
                error: (error, stackTrace) => const Center(
                  child: Text('Not found'),
                ),
                loading: () => const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  const _WeatherInfo(
    this.weather, {
    Key? key,
  }) : super(key: key);

  final CityWeather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          weather.weather.when(
            rain: () => AppAssets.rain,
            clouds: () => AppAssets.clouds,
            clear: () => AppAssets.sun,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${weather.temperature}°C',
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
