import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../user.dart';

final List<Widget> animatedActionButtons = [
  AnimatedActionButton(
    icon: Icons.shopping_bag,
    label: "Grocery",
    onTap: () {
      // Navigate to Grocery screen
    },
  ),
  AnimatedActionButton(
    icon: Icons.local_taxi,
    label: "Taxi",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.restaurant_menu,
    label: "Food",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.delivery_dining,
    label: "Pick|drop",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.sports_football,
    label: "Booking",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.fire_truck,
    label: "Logistics",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.bus_alert,
    label: "Bus",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.car_rental,
    label: "Car Pool",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.toggle_on_sharp,
    label: "Rental",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.sell,
    label: "Farm",
    onTap: () {},
  ),
  AnimatedActionButton(
    icon: Icons.room_service,
    label: "Services",
    onTap: () {},
  ),
];
List<Widget> getHomePageButtons(BuildContext context) {
  return [
    ...animatedActionButtons.take(5),
    AnimatedActionButton(
      icon: Icons.apps,
      label: "All Services",
      onTap: () {
        context.go('/services');
      },
    ),
  ];
}
