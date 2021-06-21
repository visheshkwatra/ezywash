import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  static String id = "TermsAndConditions";
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'PRIVACY POLICY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'EZY WASH attains a unique method of safeguarding, and preserving the user details provided. It complies towards Data protection. EZY WASH ensures that all users have better clarity of the information collected. Updations are constantly made on the site, for better performance and time based reviews. Data is collected from the user based on specific choices. Users may keep a constant check for changes on the site. We at EZY WASH respect your right to privacy and will keep a track of your visits on the site. By using our site, you agree to the terms of www.ezywash.com’s privacy policy.This site is subject to changes. You could keep visiting the site regularly to check the same. We also understand that you permit us to collate your details as per the policy guidelines. While you operate our site, we may process and collect your details for the number of your visits on the site, communication data, details collated from form filling process, this could be when you wish to purchase a particular product, and would like to register yourself on the site, details such as general use of internet and so on. These methods help in improving the site and to provide better service to the customers.',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "What we collect We may collect the following information:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         Name and job title",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         Contact information including email address",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         Demographic information such as postcode, preferences and interests",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         Other information relevant to customer surveys and/or offers",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "What we do with the information we gather",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         We require this information to understand your needs and provide you with a better service, and in particular for the following reasons:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         Internal record keeping.\n•         We may use the information to improve our products and services.\n•         We may periodically send promotional emails about new products, special offers or other information which we think you may find interesting using the email address which you have provided.\n•         From time to time, we may also use your information to contact you for market research purposes. We may contact you by email, phone, fax or mail. We may use the information to customize the website according to your interests.\n•         The information you provide will be shared with the servers on which we host the web content and your name and location may be shared with the Service processing centre(s) and Rider(s) we have been working with.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Sharing of personal information:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "We may share personal information with our other corporate entities and affiliates to help detect and prevent identity theft, fraud and other potentially illegal acts; correlate related or multiple accounts to prevent abuse of our services; and to facilitate joint or co-branded services that you request where such services are provided by more than one corporate entity. Those entities and affiliates may not market to you as a result of such sharing unless you explicitly opt-in.\n We may disclose personal information if required to do so by law or in the good faith belief that such disclosure is reasonably necessary to respond to subpoenas, court orders, or other legal process. We may disclose personal information to law enforcement offices, third party rights owners, or others in the good faith belief that such disclosure is reasonably necessary to: enforce our Terms or Privacy Policy; respond to claims that an advertisement, posting or other content violates the rights of a third party; or protect the rights, property or personal safety of our users or the general public.\n We and our affiliates will share / sell some or all of your personal information with another business entity should we (or our assets) plan to merge with, or be acquired by that business entity, or reorganization, amalgamation, restructuring of business. Should such a transaction occur that other business entity (or the new combined entity) will be required to follow this privacy policy with respect to your personal information.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "How we use cookies:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "A cookie is a small file which asks permission to be placed on your computer\'s or mobile hard drive. Once you agree, the file is added and the cookie helps analyze web traffic or lets you know when you visit a particular site. Cookies allow web applications to respond to you as an individual. The web application can tailor its operations to your needs, likes and dislikes by gathering and remembering information about your preferences.\n We use traffic log cookies to identify which pages are being used. This helps us analyze data about webpage traffic and improve our website in order to tailor it to customer needs. We only use this information for statistical analysis purposes and then the data is removed from the system.\n Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful and which you do not. A cookie in no way gives us access to your computer or any information about you, other than the data you choose to share with us.\n You can choose to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. This may prevent you from taking full advantage of the website.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Links to Other Sites",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "  This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. we have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Log Data",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (IP) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Service Provider",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "we may employ third-party companies and individuals due to the following reasons:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•         To facilitate our Service;\n•         To provide the Service on our behalf;\n•         To perform Service-related services; or\n•         To assist us in analyzing how our Service is used.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Security Precautions",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "'Our website has stringent security measures in place to protect the loss, misuse, and alteration of the information under our control. Whenever you change or access your account information, we offer the use of a secure server. Once your information is in our possession we adhere to strict security guidelines, protecting it against unauthorized access.\nEZY Wash is committed to ensuring that your privacy is protected. Should we ask you to provide certain information by which you can be identified when using this website, and then you can be assured that it will only be used in accordance with this privacy statement.\nThis privacy policy sets out how EZY Wash uses and protects any information that you give to EZY Wash over Phone, Website or Mobile App.\nAdvertisements on EZYWash.in\nWe may use third-party advertising companies to serve ads when you visit our Website. These companies may use information (not including your name, address, email address, or telephone number) about your visits to this and other websites in order to provide advertisements about goods and services of interest to you.\nChildren\'s Privacy\nThese Services do not address anyone under the age of 13. we do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.\nYour Consent\nBy using the website and/ or by providing your information, you consent to the collection and use of the information you disclose on the Website in accordance with this Privacy Policy, including but not limited to Your consent for sharing your information as per this privacy policy.\nIf we decide to change our privacy policy, we will post those changes on this page so that you are always aware of what information we collect, how we use it, and under what circumstances we disclose it.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "DISCLAIMER.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "\nTHE SERVICES ARE PROVIDED /AS IS/ AND /AS AVAILABLE./ TO THE MAXIMUM EXTENT PERMITTED BY LAW, EZY WASH DISCLAIMS ALL REPRESENTATIONS AND WARRANTIES, EXPRESS, IMPLIED OR STATUTORY, NOT EXPRESSLY SET OUT IN THESE TERMS, INCLUDING ANY IMPLIED WARRANTIES OF NONINFRINGEMENT, AND MAKES NO REPRESENTATION, WARRANTY, OR GUARANTEE REGARDING THE RELIABILITY, TIMELINESS, QUALITY, SUITABILITY OR AVAILABILITY OF THE SERVICES OR ANY SERVICES OR GOODS REQUESTED THROUGH THE USE OF THE SERVICES, OR THAT THE SERVICES WILL BE UNINTERRUPTED OR ERROR-FREE. EZY WASH DOES NOT GUARANTEE YOUR SAFETY WHILE DELIVERING SERVICE REQUESTS. YOU AGREE THAT THE ENTIRE RISK ARISING OUT OF YOUR USE OF THE SERVICES, AND ANY SERVICE OR GOOD REQUESTED IN CONNECTION THEREWITH, REMAINS SOLELY WITH YOU, TO THE MAXIMUM EXTENT PERMITTED UNDER APPLICABLE LAW.\nLIMITATION OF LIABILITY.\nEZY WASH SHALL NOT BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, LOST DATA RELATED TO, IN CONNECTION WITH, OR OTHERWISE RESULTING FROM ANY USE OF THE SERVICES, EVEN IF EZY WASH HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. EZY WASH SHALL NOT BE LIABLE FOR ANY DAMAGES, LIABILITY OR LOSSES ARISING OUT OF: (i) YOUR USE OF OR RELIANCE ON THE SERVICES OR YOUR INABILITY TO ACCESS OR USE THE SERVICES; OR (ii) ANY TRANSACTION OR RELATIONSHIP BETWEEN YOU AND ANY USER, EVEN IF EZY WASH HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. EZY WASH SHALL NOT BE LIABLE FOR DELAY OR FAILURE IN PERFORMANCE.\nEZY Wash may change this policy from time to time by updating this page. You should check this page from time to time to ensure that you are happy with any changes. This policy is effective from 2 April 2021.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Contacting Us",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "If there are any questions regarding this privacy policy you may contact us at our Call Centre or write to admin@ezywash.in",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "We are dedicated to providing quality service, customer satisfaction at a great value in multiple locations offering convenient hours. Our goal is to provide our customers with the friendliest, most convenient hand car wash experience possible.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "1. EZY Wash(Brand Name of SKYTECH SOLUTIONS) Cleaning Services (hereinafter referred to as ‘The Company’) reserves the right to change the prices of all / any services at its sole discretion without prior intimation to the customer.\n2. For the purposes of this Agreement Customer shall mean and include his/its nominee, assignee, agent, etc., Company shall mean and include EZY Wash and Services shall mean services to be provided by the Company as per the terms and arrangement made under this Agreement.\n3. The Company shall provide all estimates & prices at the time of booking in good faith. For removal of any doubt it is made clear that the estimates shall not mean final amount to be received by the Company and shall be subject to cost increase on the basis of other factors, on case by case basis.\n4. Prices quoted for various services are subjective and are decided by The Company based on multiple factors.\n5. For a One-time Service, The Customer agrees to pay the price quoted and confirmed and any other charges applicable to the Company in full prior to or immediately after the service.\n6. The Company reserves the right to refuse a booking without assigning any reason.\n7. The Customer must provide the Company with at least 24 hours’ notice prior to service time, if they wish to suspend, postpone or cancel the service for any reason and in the event if the customer fails to provide the said notice, without prejudice to other rights available to the Company in and under this Agreement and/or otherwise, the customer agrees to pay a cancellation fees of Rs. 1,000 per service visit confirmed by it, for administrative cost or less.\n8. If the Customer requires any additional services or any kind of variations at the time the service is being performed, the customer shall contact us at ezy wash helpline number, who may agree to provide the additional services in its absolute discretion subject to an additional cost to be decided by Company.\n9. The Customer shall provide a safe working environment at the premises for the operatives to perform the services.\n10. The Customer shall be bound to inform to the Company, prior to the commencement of the service, any hazards, slippery surfaces, potential risks or damages in the premises to be serviced.\nIn case whereof, the entire liability arising out of such defect, hazards, etc. shall be the sole and absolute liability of the Customer.\n11. Customer shall provide to the operatives/agents/employees/workers of the Company an unencumbered and unobstructed access to all service areas. The Company shall not be liable for non-performance of any services/any deficiency thereof, if the said is not provided by the Customer on the spot of the service. No claim of deficiency of service shall be claimed and entertained by the company once the job has been completed.\n12. The Company shall not be responsible for any loss or damages incurred by the Customer or any third party as a result of the effects of a force majeure, being any event beyond the reasonable control of the Company.\n13. The Company is not responsible for pre-existing defects, damages, stains and dirt that cannot be cleaned or removed with reasonable endeavor by the Company.\n14. The effectiveness and durability of service provided by the Company depends on how the premise is maintained by the occupier/user after the service delivery and also the environment in which such premise exists.\n15. The time indicated to perform the services is based on ideal conditions- there should be immediate, absolute and uninterrupted access to the premise to be serviced, no interruptions due to scenario like electricity/water outages, questions/queries by the client before or during the service delivery that might lead to delays.\n16. The company shall not be responsible for any detrimental effects on surfaces, items, fabrics, materials, etc. Owing to an unpredictable nature of surfaces, items, fabrics, materials, etc.\n17. The Company shall not be liable, whatsoever, for any pure economic loss, loss of profit, loss of business, punitive damages, any business interruption, loss of revenues or anticipated savings, depletion of goodwill, in each case whether direct or indirect or consequential or any claims for consequential loss compensation whatsoever which, arise out of or in connection with services provided under this engagement/agreement.\n18. For removal of any doubt it is made clear that in case of any penal/legal violation by the agent/worker/employee of the Company during the Service hours shall be sole responsibility of the said agent/worker/employee, etc. for which/against whom the Customer after getting a written consent from the Company may proceed individually.\n19. The Company shall not be responsible for any theft, breakages, damages and loss of any fragile items if they are not removed from the area where the service was performed.\n20. We use approved environment friendly products. However, we recommend premise owners who have a history of respiratory diseases/disorders or allergies to dust etc. should stay away from the premise while the service is carried out or declare their willingness to perform the provided services despite such disorders by signing on the declaration below for such time as may be directed/advised by the Company and/or its agent, etc.\n21. This agreement and the customer forms shall be signed by the customer or any other person(s) at the prior to and at the time of service and authority of such person to sign shall not be disputed by the customer. In the event of non-signing of this agreement it would be an implied consent to all the terms and conditions as enumerated herein.\n22. Subject to and without prejudice to the rights otherwise available to the Company, the Customer shall be liable to compensate the Company for such losses/damages which the Company has to suffer because of any act, omission, etc. of the Customer and/or his/its representative, agent, nominee, etc.\n23. It is agreed between the customer and EZY Wash Cleaning Service that courts in Delhi shall have exclusive jurisdiction in respect of any matter, claim or dispute arising out of or any way relating to the services provided by the Company.\n24. This Agreement shall be binding on all the parties.\n25. In the event of non-payment of amount then the company shall be entitled to recover the amount along with interest @ 24% per annum.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "LIMITATION AND TERMINATION OF SERVICE",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "You acknowledge and agree that EZY WASH may establish limits from time to time concerning the use of the Service, including among others, the maximum number of days that Content will be maintained or retained by the Service, the maximum number and size of postings, e-mail messages, or other Content that may be transmitted or stored by the Service, and the frequency and the manner in which you may access the Service or the Platform. You acknowledge that your account is identified and linked through your mobile number, Facebook account, or email address through which you have registered. In the event you have more than one account linked through your mobile number, Facebook account, or email address, EZY WASH reserves the right to remove or restrict the usage of such duplicate accounts. You acknowledge and agree that EZY WASH has no responsibility or liability for the deletion or failure to store any Content maintained or transmitted by the Platform or the Service. You acknowledge and agree that EZY WASH reserves the right at any time to modify, limit or discontinue the Service (or any part thereof) with or without notice and that EZY WASH shall not be liable to you or to any third party for any such modification, suspension or discontinuance of the Service. You acknowledge and agree that EZY WASH, in its sole and absolute discretion, has the right (but not the obligation) to delete or deactivate your account, block your e-mail or IP address, or otherwise terminate your access to or use of the Service (or any part thereof), immediately and without notice, and remove and discard any Content within the Service, for any reason or no reason at all, including, without limitation, if EZY WASH believes that you have violated these Terms. Further, you agree that EZY WASH shall not be liable to you or any third-party for any termination of your access to the Platform or the Service. Further, you agree not to attempt to use the Service after any such termination.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "DISCLAIMER OF WARRANTIES",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT USE OF THE PLATFORM AND THE SERVICE IS ENTIRELY AT YOUR OWN RISK AND THAT THE PLATFORM AND THE SERVICE ARE PROVIDED ON AN 'AS IS' OR AS AVAILABLE BASIS, WITHOUT ANY WARRANTIES OF ANY KIND. ALL EXPRESS AND IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF PROPRIETARY RIGHTS ARE EXPRESSLY DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. TO THE FULLEST EXTENT PERMITTED BY LAW EZY WASH, ITS OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE PLATFORM AND YOUR USE THEREOF. EZY WASH MAKES NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE PLATFORM\'S CONTENT OR THE CONTENT OF ANY THIRD-PARTY WEBSITES LINKED TO THE PLATFORM AND ASSUMES NO LIABILITY OR RESPONSIBILITY FOR ANY (I) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT, (II) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE PLATFORM AND SERVICE, (III) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (IV) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE PLATFORM, (IV) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE PLATFORM BY ANY THIRD PARTY, AND/OR (V) ANY ERRORS OR OMISSIONS IN ANY CONTENT OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, EMAILED, COMMUNICATED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE PLATFORM OR THE SERVICE. EZY WASH DOES NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE PLATFORM OR ANY HYPERLINKED WEBSITE OR FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND EZY WASH WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND/OR OTHER USERS AND/OR THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "LIMITATIONS OF LIABILITY",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "\nIN NO EVENT SHALL EZY WASH, ITS OFFICERS, DIRECTORS, EMPLOYEES, OR AGENTS, BE LIABLE FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR EXEMPLARY DAMAGES (EVEN IF EZY WASH HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), RESULTING FROM ANY ASPECT OF YOUR USE OF THE PLATFORM OR THE SERVICE, INCLUDING WITHOUT LIMITATION WHETHER THE DAMAGES ARISE FROM USE OR MISUSE OF THE PLATFORM OR THE SERVICE, FROM INABILITY TO USE THE PLATFORM OR THE SERVICE, OR THE INTERRUPTION, SUSPENSION, MODIFICATION, ALTERATION, OR TERMINATION OF THE PLATFORM OR THE SERVICE. SUCH LIMITATION OF LIABILITY SHALL ALSO APPLY WITH RESPECT TO DAMAGES INCURRED BY REASON OF OTHER SERVICES OR PRODUCTS RECEIVED THROUGH OR ADVERTISED IN CONNECTION WITH THE PLATFORM OR THE SERVICE OR ANY LINKS ON THE PLATFORM, AS WELL AS BY REASON OF ANY INFORMATION, OPINIONS OR ADVICE RECEIVED THROUGH OR ADVERTISED IN CONNECTION WITH THE PLATFORM OR THE SERVICE OR ANY LINKS ON THE EZY WASH SITE. THESE LIMITATIONS SHALL APPLY TO THE FULLEST EXTENT PERMITTED BY LAW. YOU SPECIFICALLY ACKNOWLEDGE AND AGREE THAT EZY WASH SHALL NOT BE LIABLE FOR USER SUBMISSIONS OR THE DEFAMATORY, OFFENSIVE, OR ILLEGAL CONDUCT OF ANY USER OR THIRD PARTY AND THAT THE RISK OF HARM OR DAMAGE FROM THE FOREGOING RESTS ENTIRELY WITH YOU. THE PLATFORM IS CONTROLLED AND OFFERED BY EZY WASH. EZY WASH MAKES NO REPRESENTATIONS OR WARRANTIES THAT THE PLATFORM IS APPROPRIATE FOR USE IN OTHER LOCATIONS. THOSE WHO ACCESS OR USE THE PLATFORM FROM OTHER JURISDICTIONS DO SO AT THEIR OWN VOLITION AND RISK AND ARE RESPONSIBLE FOR COMPLIANCE WITH LOCAL LAW.\nABILITY TO ACCEPT TERMS OF SERVICE\nThis Platform is intended only for adults and that you are eligible to contract as per applicable laws. If you are using/accessing this Platform as a representative of any person/entity, you acknowledge that you are legally authorized to represent that person/entity. Minors, i.e. users under 18 years of age, are only allowed to access the Platform and use the Service, in the event of approval of their legal representatives or in the event that it concerns an act or a transaction that is a usual and acceptable standard in civil life and practice. You affirm that you are either at least 18 years of age, or an emancipated minor, or possess legal parental or guardian consent and are fully able and competent to enter into the terms, conditions, obligations, affirmations, representations, and warranties set forth in these Terms, and to abide by and comply with these Terms. In any case, you affirm that you are over the age of 13, as the Platform is not intended for children under 13.\nNOTICE TO CHILDREN UNDER THE AGE OF 13 AND THEIR PARENTS OR GUARDIANS If you are under the age of 13, YOU MUST NOT USE THIS PLATFORM. Please do not send us your personal information, including your email addresses, name, and/or contact information. If you want to contact us, you may only do so through your parent or legal guardian.\nTerms of Condition for the application Uses\nBy downloading or using the application or website, these terms will automatically apply to you - you should make sure therefore that you read them carefully before using the application or website. EZY Wash is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you\'re paying for. The app does use third party services that declare their own Terms and Conditions. You should be aware that there are certain things that EZY Wash will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but EZY Wash cannot take responsibility for the app not working at full functionality if you don\'t have access to Wi-Fi, and you don\'t have any of your data allowance left.\nIf you\'re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you\'re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you\'re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\nAlong the same lines, EZY Wash cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged - if it runs out of battery and you can\'t turn it on to avail the Service, EZY Wash cannot accept responsibility.\nWith respect to EZY Wash\'s responsibility for your use of the app, when you\'re using the app, it\'s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. EZY Wash accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\nAt some point, we may wish to update the app. The app is currently available on Android - the requirements for system (and for any additional systems we decide to extend the availability of the app to) may change, and you\'ll need to download the updates if you want to keep using the app. EZY Wash does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.\nCar cleaning",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•	Monthly Payment needs to be paid in advance .Failing incase will lead to withdraw the car cleaning service from company side.\n•	In case your payment process is failed due to any system issues, your money will be refunded to your specific bank account or by UPI.\n•	Company is not responsible for quality of work due to bad weather condition i.e. rain, fog etc.\n•	Due to having bad weather condition, if company washer fails to wash the car after reaching your place, that day would be counted within your service days.\n•	Incase company fails to take your interior on the specified day, company will make sure that they will follow up that interior in next 3-4 days. By the end of month company will make sure that you have received your all services.\n•	If you don’t receive your all services at the end of the month, you can report that to company so that your pending services get adjusted in the consecutive month of the service.\n•	Company is bound to clean only the specific car for which you have taken the service, not any other car if your specified car is not present there.\n•	In case the car washer would not get the car (booked for service) present on scheduled time, the day will also be included within your booked service days.\n•	Getting any other cleaning service by company, will cost you additional charges.\n•	All the prices mentioned here are exclusive of taxes, taxes as Applicable.\n•	You are requested to remove all sorts of luggage and belongings before you hand over the car for a wash. If there is still anything left in the car on the time of washing, the company won’t take any responsibility for any damage or loss of those things.\n•	Complete interior & exterior cleaning of your car\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Protection against damages up to Rs. 1000.\n•	Use of modern equipment and machinery.\n•	Highly trained professional car cleaners.\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      " Bike Cleaning",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      " •	Monthly Payment needs to be paid in advance .Failing incase will lead to withdrawal of the Bike cleaning service from the company side.\n•	In case your payment process fails due to any system issues, your money will be refunded to your specific bank account or by UPI.\n•	Company is not responsible for the quality of work due to bad weather conditions i.e. rain, fog etc.\n•	Due to bad weather conditions, if the company washer fails to wash the Bike after reaching your place, that day would be counted within your service days.\n•	If you don’t receive your all services at the end of the month, you can report that to the company so that your pending services get adjusted in the consecutive month of the service.\n•	Company is bound to clean only the specific Bike for which you have taken the service, not any other Bike if your specified bike is not present there.\n•	In case the bike washer does not get the bike (booked for service) present on scheduled time, the day will also be included within your booked service days.\n•	Getting any other cleaning service by the company will cost you additional charges.\n•	All the prices mentioned here are exclusive of taxes, taxes as Applicable.\n•	All the rules written above in the bike cleaning section are applicable on per visit services also.\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Protection against damages up to Rs. 1000.\n•	Use of modern equipment and machinery.\n•	Highly trained professional bike cleaners.\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      " Home cleaning",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•	Scrubbing machine is optional - So customer should request prior for such requirements.\n•	Customers are requested to examine the cleaning before executives leave the place. We are not responsible for any damage reported after processing.\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Protection against damages up to Rs. 10,000.\n•	Use of modern equipment and machinery\n.•	Verified & trained cleaners.\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.\n",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Sofa Carpet Mattress cleaning",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•	Mechanized Equipment & Professional Cleaning solutions\n•	Customers are requested to examine the cleaning before executives leave the place. We are not responsible for any damage reported after processing.\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Protection against damages up to Rs. 10,000.\n•	Use of modern equipment and machinery.\n•	Highly trained & Background verified cleaners.\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Pest control",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•	Treatment with Internationally certified Pest Control chemicals\n•	Pest removal assured, 30 Days Service Warranty\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Protection against damages up to Rs. 10,000.\n•	Use of modern equipment and machinery.\n•	Highly trained & Background verified technicians\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.\n",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Sanitizations service",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "•	Treatment with certified Sanitizers\n•	We are not responsible for any kind of allergic condition after the sanitization process in the area.\n•	Any issues should be reported to 'EZY Wash' customer care within 24 hours of service.\n•	Use of modern equipment and machinery.\n•	Highly trained & Background verified technicians\n•	All communication will happen via SMS or Email only, so request you to check all the SMSs and Emails.\n",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      " Changes to This Terms and Conditions",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "We may update our Terms and Conditions any times. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page. These terms and conditions are effective as of 20 April 2021.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "If you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at admin@ezywash.in.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Our Measures against COVID-19?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "WHO Recommended Protective Gears.\nOur executives will eter your home/office, only after wearing WHO recommended protective gears, covering him head to toe.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Safety Measures",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Our executives are trained on all safety measures as per WHO guidelines and use sanitized equipment & tools.\nDaily Temperature Check.\nOur executive will be checked for temperature everyday.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Arogya Setu APP",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      "Our executives will display their status in their Arogya Setu APP before entering your premises.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
