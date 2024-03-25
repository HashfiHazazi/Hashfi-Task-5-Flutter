import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task5_application/src/modules/local_storage/login_local_storage.dart';
import 'package:task5_application/src/routers/route_names.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 156,
                    height: 156,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.10),
                        shape: BoxShape.circle),
                    child: LottieBuilder.asset(
                        'assets/lotties/lottie_profile.json'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: LoginLocalStorage.getUserName(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        snapshot.data,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 19,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: ',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  FutureBuilder(
                    future: LoginLocalStorage.getUserEmail(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(snapshot.data,
                          style: Theme.of(context).textTheme.titleLarge!);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 19,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number: ',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  FutureBuilder(
                    future: LoginLocalStorage.getUserPhoneNumber(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(snapshot.data,
                          style: Theme.of(context).textTheme.titleLarge!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: ElevatedButton(
                onPressed: () async {
                  await LoginLocalStorage.clearStorage();
                  if (context.mounted) {
                    Navigator.pushNamed(context, RouteNames.login);
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0.25,
                    backgroundColor: const Color(0xFFB22727)),
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            )
          ],
        ));
  }
}
