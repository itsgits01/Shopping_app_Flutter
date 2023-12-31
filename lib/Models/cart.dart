import 'package:first_app/Models/catalog.dart';
import 'package:first_app/core/store.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel{


  late CatalogModel _catalog;

  final List<int> _itemIDs=[];

  CatalogModel get catalog=> _catalog;

  set catalog(CatalogModel newCatalog){
    assert(newCatalog!=null);
    _catalog=newCatalog;
  }

  List<Item> get items=> _itemIDs.map((id) => _catalog.getItembyId(id)).toList();

  num get totalPrice=> items.fold(0,(total,current)=>total +current.price);

}

class AddMutation extends VxMutation<MyStore>{
  final Item item;

  AddMutation(this.item);
  
  
  @override
  perform() {
    // TODO: implement perform
    store?.cart._itemIDs.add(item.id);
  }

}

class RemoveMutation extends VxMutation<MyStore>{
  final Item item;

  RemoveMutation(this.item);


  @override
  perform() {
    // TODO: implement perform
    store?.cart._itemIDs.remove(item.id);
  }

}