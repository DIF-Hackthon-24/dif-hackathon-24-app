import 'package:flutter/material.dart';

/// Any module providing bill payments view should implement this abstract
/// view to resolve the view implementation via DI container
abstract class IBillPaymentsView extends StatelessWidget {
  const IBillPaymentsView({Key? key,}):super(key: key);
}