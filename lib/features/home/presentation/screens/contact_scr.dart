import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/core/utils/general_functions/g_fun_valid.dart';
import 'package:ghosno/core/utils/general_widgets/g_widget_loading.dart';
import 'package:ghosno/features/home/domain/usecases/send_comment_uc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../cart/screens/cart_scr.dart';
import '../controller/home_bloc.dart';
import '../widgets/contact_widgets/contact_widget_success_pop_up.dart';
import '../widgets/contact_widgets/contact_widget_textfield.dart';
import '../widgets/home_widget_appbar.dart';

class ContactScr extends StatefulWidget {
  const ContactScr({super.key});
  static const route = '/contact';

  @override
  State<ContactScr> createState() => _ContactScrState();
}

class _ContactScrState extends State<ContactScr> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  String? _emailErrorMsg;
  String? _phoneErrorMsg;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDesktop = screenWidth > 800;

    final PreferredSizeWidget customAppBar = HomeWidgetAppbar(
      isDesktop: isDesktop,
      onCart: () {
        _scaffoldKey.currentState?.openEndDrawer();
      },
    ).appbar(context);

    final double appBarHeight = customAppBar.preferredSize.height;

    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.homeRequestState == RequestState.loaded) {
              setState(() {
                _name.text = '';
                _email.text = '';
                _phone.text = '';
                _comment.text = '';
              });
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const ContactWidgetSuccessPopUp();
                },
              );
            }
          },
          listenWhen: (previous, current) =>
              previous.homeRequestState != current.homeRequestState,
          builder: (context, state) => Scaffold(
              key: _scaffoldKey,
              endDrawer: const CartScr(),
              body: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isDesktop = constraints.maxWidth > 800;

                              return Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 900),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 48.0 : 24.0,
                                  vertical: 40.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 80),
                                    Text(
                                      'Contact',
                                      style: AppFont(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    if (isDesktop)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ContactWidgetTextfield(
                                                controller: _name,
                                                label: 'Name'),
                                          ),
                                          const SizedBox(width: 24),
                                          Expanded(
                                            child: ContactWidgetTextfield(
                                                controller: _email,
                                                label: 'Email *',
                                                errorMessage: _emailErrorMsg),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ContactWidgetTextfield(
                                              controller: _name, label: 'Name'),
                                          SizedBox(height: 16),
                                          ContactWidgetTextfield(
                                              controller: _email,
                                              label: 'Email *',
                                              errorMessage: _emailErrorMsg),
                                        ],
                                      ),
                                    const SizedBox(height: 16),
                                    ContactWidgetTextfield(
                                        isDigits: true,
                                        controller: _phone,
                                        errorMessage: _phoneErrorMsg,
                                        label: 'Phone number'),
                                    const SizedBox(height: 16),
                                    ContactWidgetTextfield(
                                      controller: _comment,
                                      label: 'Comment',
                                      maxLines: 5,
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      width: isDesktop ? 120 : 140,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _emailErrorMsg = null;
                                            _phoneErrorMsg = null;
                                          });
                                          if (_email.text.isEmpty) {
                                            _emailErrorMsg = 'Enter an email';
                                          } else {
                                            if (!GFunValid.isValidEmail(
                                                _email.text)) {
                                              _emailErrorMsg =
                                                  'Enter a valid email';
                                            }
                                          }
                                          if (_phone.text.isNotEmpty) {
                                            if (!GFunValid.isValidEgyptianPhone(
                                                _phone.text)) {
                                              _phoneErrorMsg =
                                                  'Enter a valid phone number';
                                            }
                                          }

                                          setState(() {});
                                          if (_phoneErrorMsg != null ||
                                              _emailErrorMsg != null) {
                                            return;
                                          }
                                          context.read<HomeBloc>().add(
                                              SendCommentEvent(
                                                  sendCommentParameters:
                                                      SendCommentParameters(
                                                          name:
                                                              _name.text
                                                                      .isEmpty
                                                                  ? ''
                                                                  : _name.text,
                                                          email: _email.text,
                                                          phone: _phone
                                                                  .text.isEmpty
                                                              ? ''
                                                              : _phone.text,
                                                          comment: _comment
                                                                  .text.isEmpty
                                                              ? ''
                                                              : _comment
                                                                  .text)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: state.homeRequestState ==
                                                RequestState.loading
                                            ? GWidgetLoadingCircle(
                                                color: Colors.white,
                                                strokeWidth: 2.8,
                                                width: 28,
                                                height: 28)
                                            : Text(
                                                'Send',
                                                style: AppFont(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 60)
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: appBarHeight,
                      color: Colors.white,
                      child: customAppBar,
                    ),
                  ),
                ],
              ))),
    );
  }
}
