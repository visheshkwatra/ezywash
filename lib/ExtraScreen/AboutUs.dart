import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  static String id = 'AboutUs';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Theme.of(context).colorScheme.background,
                shadowColor: Theme.of(context).colorScheme.secondary,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: [
                      Text(
                        'About us',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'We EZY WASH is a young startup in Delhi/NCR, offering organized and professional doorstep car washing services. We hold great experience of serving various industries from more than 5 years. Our professional car cleaners are trained well before we allocate them washing job.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '*Professional Service',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Get ready to experience the complete professionally managed car cleaning services.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '*Reliable Packages',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'We understand your budget and that is why all our packages are 100% pocket friendly.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '*Customer Care',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Need a help or support, our customer care executives are available to assist you.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '*100% Satisfaction',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'We promise and assure you, 100% satisfaction with our work and work process',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
