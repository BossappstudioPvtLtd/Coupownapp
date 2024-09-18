
// Define the PlanModal class
class PlanModal {
  final String title;
  final String subTitle;
  final String price;
  final String planPriceSubTitle;
  final List<PlanModal> optionList;

  PlanModal({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.planPriceSubTitle,
    required this.optionList,
  });
}

// Define a class or widget that will use the init method
class PlanInitializer {
  List<PlanModal> planList = [];

  Future<void> init() async {
    planList.add(
      PlanModal(
        title: '',
        subTitle: 'A Simplest Start to everyone',
        price: 'Free Trial',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(
            title: 'Up to 1 user',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Up to 20 records per month',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Single record',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
        ],
      ),
    );

    planList.add(
      PlanModal(
        title: 'Basic',
        subTitle: 'A Simplest Start to everyone',
        price: '99 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(
            title: 'Up to 10 users',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Up to 100 records per month',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Single record',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
        ],
      ),
    );

    planList.add(
      PlanModal(
        title: 'Standard',
        subTitle: 'For Small and medium business',
        price: '199 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(
            title: 'Up to 20 users',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Up to 200 records per month',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Single Company record',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
        ],
      ),
    );

    planList.add(
      PlanModal(
        title: 'Enterprise',
        subTitle: 'Solution for big organization',
        price: '299 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(
            title: 'Unlimited users',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Unlimited records',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
          PlanModal(
            title: 'Multiple Company records',
            subTitle: '',
            price: '',
            planPriceSubTitle: '',
            optionList: [],
          ),
        ],
      ),
    );

    // The planList is now populated and can be used or stored as needed
  }
} 

