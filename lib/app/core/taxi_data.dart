import 'package:flutter/material.dart';

class TaxiData {
  static const List<Map<String, dynamic>> onboardingSlides = [
    {
      "title": "Request a Ride",
      "desc": "Request a ride get picked up by a nearby community driver",
      "icon": Icons.map_outlined,
    },
    {
      "title": "Confirm Your Driver",
      "desc":
          "Huge drivers network helps you find comfortable, safe and cheap ride",
      "icon": Icons.local_taxi_outlined,
    },
    {
      "title": "Track your ride",
      "desc":
          "Know your driver in advance and be able to view current location in real time",
      "icon": Icons.location_on_outlined,
    },
  ];

  static const List<Map<String, dynamic>> rideTypes = [
    {
      "id": "econo",
      "name": "Economy",
      "image": "assets/images/taxi/taxi-home.jpg",
      "price_multiplier": 1.0,
      "eta": "4 min",
      "capacity": 4,
      "desc": "Affordable, everyday rides",
    },
    {
      "id": "comfort",
      "name": "Comfort",
      "image": "assets/images/taxi/taxi-home.jpg",
      "price_multiplier": 1.4,
      "eta": "6 min",
      "capacity": 4,
      "desc": "Newer cars with extra legroom",
    },
    {
      "id": "lux",
      "name": "Luxury",
      "image": "assets/images/taxi/taxi-home.jpg",
      "price_multiplier": 2.2,
      "eta": "9 min",
      "capacity": 4,
      "desc": "Premium rides in high-end cars",
    },
    {
      "id": "van",
      "name": "Van",
      "image": "assets/images/taxi/taxi-home.jpg",
      "price_multiplier": 1.8,
      "eta": "12 min",
      "capacity": 6,
      "desc": "Rides for groups up to 6",
    },
  ];

  static const List<Map<String, dynamic>> recentLocations = [
    {
      "name": "Office",
      "address": "123 Business Park, Tech City",
      "icon": Icons.work,
    },
    {
      "name": "Home",
      "address": "45 Green Layout, Suburbia",
      "icon": Icons.home,
    },
    {
      "name": "Central Mall",
      "address": "88 Shopping Ave, Downtown",
      "icon": Icons.shopping_bag,
    },
  ];
}
