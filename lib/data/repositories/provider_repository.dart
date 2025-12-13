import '../../models/provider_model.dart';

class ProviderRepository {
  List<ProviderModel> fetchProviders() {
    return [
      ProviderModel(
        id: '1',
        name: 'Sofa Cleaning Expert',
        price: '₹ 800',
        rating: '4.3',
        image: 'assets/images/sofa_cleaner.png',
      ),
      ProviderModel(
        id: '2',
        name: 'Deep Cleaning Service',
        price: '₹ 950',
        rating: '4.5',
        image: 'assets/images/deep_cleaner.png',
      ),
      ProviderModel(
        id: '3',
        name: 'Bathroom Cleaner',
        price: '₹ 700',
        rating: '4.2',
        image: 'assets/images/bathroom_cleaner.png',
      ),
      ProviderModel(
        id: '4',
        name: 'Chimney Cleaner',
        price: '₹ 850',
        rating: '4.4',
        image: 'assets/images/chimny_cleaner.png',
      ),
    ];
  }
}
