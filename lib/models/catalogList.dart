import 'package:new_application/models/cartmodel.dart';
import 'package:new_application/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:new_application/models/homedetailpage.dart';
import 'package:velocity_x/velocity_x.dart';

import 'addtocart.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return !context.isMobile? GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20),
      shrinkWrap: true,
      itemCount: CatalogModel.products!.length,
      itemBuilder: (context, index){
        final catalog = CatalogModel.products![index];
        return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDetailPage(catalog: catalog))),
            child: CatalogItem(catalog: catalog));
      },
    ) : ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.products!.length,
      itemBuilder: (context, index){
        final catalog = CatalogModel.products![index];
        return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDetailPage(catalog: catalog))),
            child: CatalogItem(catalog: catalog));
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({super.key, required this.catalog}): assert(catalog!= null);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image).box.rounded.p8.color(Colors.white70).make().p16().w40(context)),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(),
                  catalog.name.text.lg.bold.make(),
                  catalog.desc.text.textStyle(context.captionStyle).make(),
                  10.heightBox,
               ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: Vx.mOnly(right: 8),
                children: [
                  "₹${catalog.price}".text.bold.xl.make(),
                  AddtoCart(catalog: catalog),
                ],
              ).pOnly(right: 10),
            ],
          ))
        ],
      ),
    ).color(context.cardColor).roundedLg.square(150).make().py16();
  }
}

