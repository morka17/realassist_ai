import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realassist_ai/src/presentation/provider/chat_provider.dart';

void showSubscribeDialog(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return SizedBox(
        child: Container(
          // height: 400,
          // width: 230,
          // decoration: BoxDecoration(color: Color(0XFF26228F)),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Positioned(
                top: size.height * 0.5 - (330 * 0.5),
                right: ((size.width - 280) * 0.5),
                child: const Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
              ),
              Positioned(
                top: size.height * 0.5 - (330 * 0.5),
                right: (size.width - 280) * 0.5,
                child: Container(
                  width: 280,
                  height: 330,
                  decoration: BoxDecoration(
                    color: Color(0XFF26228F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Text(
                          "Subscribe and enjoy full features",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      Container(
                        width: 280,
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Text(
                                  "With subscription, get over 500,000 word every month",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  backgroundColor: const Color(0XFF443DF6),
                                ),
                                onPressed: () {
                                  context.read<ChatProvider>().subscribed =
                                      true;
                                  Navigator.pop(context);
                                },
                                child: Text("Subscribe Now",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.5 - (330 * 0.5) - 10,
                right: ((size.width - 280) * 0.5) - 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.cancel_rounded,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
