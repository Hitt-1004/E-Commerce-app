import 'package:new_application/models/catalog.dart';
import 'package:new_application/models/store.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel{
  // static final cartModel = CartModel._internal();
  // CartModel._internal();
  // factory CartModel() => cartModel;

  //catalog field
  late CatalogModel _catalog;

  //collection of ids
  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog){
    _catalog = newCatalog;
  }

  //Get items in the cart
  List<Item> get items => _itemIds.map((id)=>_catalog.getById(id)).toList();

  //Get total price
  num get totalPrice => items.fold(0, (total, current) => total + current.price);

  //Add item
  // void add(Item item){
  //   _itemIds.add(item.id);
  // }
  //Remove item
  // void remove(Item item){
  //   _itemIds.remove(item.id);
  // }
}

class AddMutation extends VxMutation<MyStore>{
  final Item item;
  AddMutation(this.item);
  @override
  perform() {
   store?.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore>{
  final Item item;
  RemoveMutation(this.item);
  @override
  perform() {
    store?.cart._itemIds.remove(item.id);
  }
}