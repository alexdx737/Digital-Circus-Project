import 'package:flutter/foundation.dart';
import 'package:circusweb/core/routing/route_name.dart';

class PaginatedHook extends ChangeNotifier {
	final List<String> _flow = List<String>.from(RouteName.flow);

	final Map<String, String> _widgetFileByRoute = {
		RouteName.welcome: 'lib/app/app.dart',
		RouteName.catalog: 'lib/modules/catalog/presentation/views/catalog_page.dart',
		RouteName.orders: 'lib/modules/orders/presentation/views/orders_page.dart',
		RouteName.profile: 'lib/modules/profile/presentation/views/profile_page.dart',
	};

	int _index = 0;

	int get index => _index;
	String get currentRoute => _flow[_index];
	bool get hasNext => _index < _flow.length - 1;
	bool get hasPrevious => _index > 0;
	List<String> get routes => List.unmodifiable(_flow);

	String widgetFileForCurrentRoute() {
		return _widgetFileByRoute[currentRoute] ?? '';
	}

	String widgetFileForRoute(String route) {
		return _widgetFileByRoute[route] ?? '';
	}

	void syncFromRoute(String route) {
		final nextIndex = _flow.indexOf(route);
		if (nextIndex == -1 || nextIndex == _index) {
			return;
		}
		_index = nextIndex;
		notifyListeners();
	}

	String nextRoute() {
		if (!hasNext) {
			return currentRoute;
		}
		_index++;
		notifyListeners();
		return _flow[_index];
	}

	String previousRoute() {
		if (!hasPrevious) {
			return currentRoute;
		}
		_index--;
		notifyListeners();
		return _flow[_index];
	}

	String goTo(String route) {
		final target = _flow.indexOf(route);
		if (target == -1) {
			return currentRoute;
		}
		_index = target;
		notifyListeners();
		return _flow[_index];
	}
}
