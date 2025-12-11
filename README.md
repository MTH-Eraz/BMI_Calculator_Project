# BMI Calculator (Flutter)

A robust BMI calculator application built with Flutter that supports multiple units for weight and height inputs, providing accurate BMI calculation and categorized results with visual feedback.

## ✨ Features

* **Multi-Unit Support:** Accepts weight and height inputs in various units.
* **Dynamic Conversions:** Automatically converts all inputs to the metric system (kg and meters) before calculation.
* **Clear Categorization:** Displays the BMI score and classifies it into standard categories (Underweight, Normal, Overweight, Obese).
* **Visual Feedback:** Uses color-coded results for quick interpretation.
* **User-Friendly Interface:** Clean, light-themed design with segmented controls for easy unit switching.

## 📐 Unit Support & Conversions

| Measurement | Supported Units | Conversion Factors (to Metric) |
| :--- | :--- | :--- |
| **Weight** | Kilograms (kg) | Base Unit |
| | Pounds (lb) | $1 \text{ lb} = 0.45359237 \text{ kg}$ |
| **Height** | Meters (m) | Base Unit |
| | Centimeters (cm) | $1 \text{ cm} = 0.01 \text{ m}$ |
| | Feet & Inches (ft + in) | $1 \text{ in} = 0.0254 \text{ m}$ |

## 📊 BMI Classification

The application uses the standard WHO (World Health Organization) BMI ranges:

| BMI Range | Category | Result Color |
| :--- | :--- | :--- |
| BMI < 18.5 | Underweight | 🟦 Blue |
| 18.5 – 24.9 | Normal | 🟩 Green |
| 25.0 – 29.9 | Overweight | 🟧 Orange |
| ≥ 30.0 | Obese | 🟥 Red |

## 🛠️ Project Structure & Technology

This project is built using the Flutter framework and follows a clean separation of concerns across three main files:

* **`main.dart`**: Contains the main application entry point and the overall Light Theme configuration (`MaterialApp`).
* **`bmi_cal.dart`**: The core logic file. It manages the application state, unit toggles, all unit conversion functions (`getWeightInKg`, `getHeightInMeter`), BMI calculation, and result categorization.
* **`input_fuild.dart`**: A reusable stateless widget for customized text input fields (`Appinputfuild`) with proper numeric keyboard and decoration settings.

### Dependencies

* [Flutter SDK](https://flutter.dev/docs/get-started/install)

## 🚀 Getting Started

To get a copy of the project up and running on your local machine, follow these simple steps.

### Prerequisites

You must have the Flutter SDK installed on your system.

```bash
flutter doctor
