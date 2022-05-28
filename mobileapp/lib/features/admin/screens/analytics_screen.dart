import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/features/admin/models/sales.dart';
import 'package:mobileapp/features/admin/services/admin_services.dart';
import 'package:mobileapp/features/admin/widgets/category_product_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earning;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData["totalEarnings"];
    earning = earningData["sales"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earning == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                      id: "Sales",
                      data: earning!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning),
                ]),
              ),
            ],
          );
  }
}
