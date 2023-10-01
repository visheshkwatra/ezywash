///Model Class for Car Categories - Hatchback , Sedan , Suv  , Mpv etc.
class CarCategories {
  String name, imgData;
  int id;

  /// Contains all car categories.
  /// Creating static because it is calling just after opening the app.
  static List<CarCategories> carCategories = [
    CarCategories(name: 'Interior', imgData: '', id: 1),
    CarCategories(name: 'Exterior', imgData: '', id: 2),
    CarCategories(name: 'Interior & Exterior Combo', imgData: '', id: 3),
    CarCategories(name: 'Monthly', imgData: '', id: 4),
  ];

  CarCategories({required this.name, required this.imgData, required this.id});
}

/*
  {
        "id": 1,
        "m_cat": 1,
        "name": "Intertior",
        "slug": "interior"
    },
    {
        "id": 2,
        "m_cat": 1,
        "name": "Exterior",
        "slug": "exterior"
    },
    {
        "id": 3,
        "m_cat": 1,
        "name": "Interior & Exterior Combo",
        "slug": "combo"
    },
    {
        "id": 4,
        "m_cat": 1,
        "name": "Monthly",
        "slug": "monthly"
    }
*/
