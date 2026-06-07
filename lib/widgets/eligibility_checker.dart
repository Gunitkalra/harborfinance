import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../services/eligibility_service.dart';
import 'custom_button.dart';

class EligibilityChecker extends StatefulWidget {
  final VoidCallback onApplySuccess;

  const EligibilityChecker({super.key, required this.onApplySuccess});

  @override
  State<EligibilityChecker> createState() => _EligibilityCheckerState();
}

class _EligibilityCheckerState extends State<EligibilityChecker> {
  // Form values
  String _selectedCountry = "United States (USA)";
  final TextEditingController _uniController = TextEditingController(text: "Boston University");
  final TextEditingController _courseController = TextEditingController(text: "MS in Computer Science");
  double _loanAmount = 50000; // USD

  // Calculation state
  bool _isLoading = false;
  String _loadingStep = "";
  EligibilityResult? _result;

  final List<String> _countries = [
    "United States (USA)",
    "Canada",
    "United Kingdom (UK)",
    "Australia",
    "Germany",
    "Ireland"
  ];

  @override
  void dispose() {
    _uniController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _calculate() async {
    setState(() {
      _isLoading = true;
      _result = null;
    });

    // Animate loader steps for premium fintech experience
    final steps = [
      "Securing connection to partner networks...",
      "Evaluating academic profile standards...",
      "Checking non-collateral loan limits...",
      "Matching with 15+ global lenders..."
    ];

    for (var step in steps) {
      if (!mounted) return;
      setState(() => _loadingStep = step);
      await Future.delayed(const Duration(milliseconds: 450));
    }

    final res = await EligibilityService.checkEligibility(
      country: _selectedCountry,
      university: _uniController.text,
      course: _courseController.text,
      loanAmountUSD: _loanAmount,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        _result = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 950),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.secondary.withAlpha(20), width: 1.5),
        boxShadow: AppColors.premiumShadow,
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _isLoading 
              ? _buildLoadingState() 
              : (_result != null ? _buildResultsState() : _buildFormState()),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(25),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "FREE ASSESSMENTS",
                style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Takes less than 60 seconds",
              style: AppTextStyles.body(13, color: AppColors.textLight),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Check Loan Eligibility",
          style: AppTextStyles.heading(28, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        Text(
          "Get instant feedback on interest rates, loan limits, and public vs private lender options.",
          style: AppTextStyles.body(15, color: AppColors.textLight),
        ),
        const SizedBox(height: 28),
        
        // Form Layout (Responsive Grid)
        LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isNarrow = width < 600;

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isNarrow ? 1 : 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Target Destination"),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountry,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down, color: AppColors.textLight),
                                items: _countries.map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c, style: AppTextStyles.body(15, color: AppColors.textDark)),
                                )).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedCountry = val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isNarrow) const SizedBox(width: 20),
                    if (!isNarrow)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Target University"),
                            _buildTextField(_uniController, "e.g., Boston University", Icons.school_outlined),
                          ],
                        ),
                      ),
                  ],
                ),
                if (isNarrow) ...[
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Target University"),
                      _buildTextField(_uniController, "e.g., Boston University", Icons.school_outlined),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Course / Degree"),
                          _buildTextField(_courseController, "e.g., MS in Computer Science", Icons.menu_book_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Loan amount slider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel("Required Loan Amount (USD)"),
                        Text(
                          "\$${_loanAmount.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}",
                          style: AppTextStyles.heading(18, color: AppColors.secondary, weight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.secondary,
                        inactiveTrackColor: AppColors.secondary.withAlpha(30),
                        thumbColor: AppColors.secondary,
                        overlayColor: AppColors.secondary.withAlpha(20),
                        valueIndicatorColor: AppColors.secondary,
                      ),
                      child: Slider(
                        min: 10000,
                        max: 150000,
                        divisions: 28,
                        label: "\$${(_loanAmount / 1000).toInt()}k",
                        value: _loanAmount,
                        onChanged: (val) => setState(() => _loanAmount = val),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$10,000", style: AppTextStyles.body(12)),
                        Text("\$80,000", style: AppTextStyles.body(12)),
                        Text("\$150,000", style: AppTextStyles.body(12)),
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
        
        const SizedBox(height: 32),
        Center(
          child: CustomButton(
            text: "Check Loan Eligibility",
            onPressed: _calculate,
            icon: Icons.rocket_launch_outlined,
            glowEffect: true,
            width: 280,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildLoadingState() {
    return Container(
      height: 350,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 72,
            height: 72,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),
          const SizedBox(height: 36),
          Text(
            "Evaluating Options",
            style: AppTextStyles.heading(22),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              _loadingStep,
              key: ValueKey(_loadingStep),
              style: AppTextStyles.body(15, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsState() {
    final res = _result!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
              onPressed: () => setState(() => _result = null),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withAlpha(25),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, size: 14, color: AppColors.accentGreen),
                  const SizedBox(width: 4),
                  Text(
                    res.status.toUpperCase(),
                    style: AppTextStyles.body(11, color: AppColors.accentGreen, weight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Main Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isNarrow = width < 600;

            return Flex(
              direction: isNarrow ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular Gauge
                Expanded(
                  flex: isNarrow ? 0 : 2,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            height: 140,
                            child: CustomPaint(
                              painter: _ScoreGaugePainter(score: res.score),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${res.score.toInt()}%",
                                style: AppTextStyles.display(32, color: AppColors.textDark, weight: FontWeight.w800),
                              ),
                              Text(
                                "LQI Score",
                                style: AppTextStyles.body(11, color: AppColors.textLight, weight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ).animate().scale(delay: 100.ms, duration: 400.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 16),
                      Text(
                        "Loan Qualification Index",
                        style: AppTextStyles.heading(15, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
                
                if (isNarrow) const SizedBox(height: 24) else const SizedBox(width: 32),
                
                // Detailed Metrics
                Expanded(
                  flex: isNarrow ? 0 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Terms",
                        style: AppTextStyles.heading(20, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 16),
                      _buildMetricRow("Estimated Rate", "Starting @ ${res.interestRate.toStringAsFixed(2)}% p.a."),
                      _buildMetricRow("Estimated EMI", "\$${res.estimatedEmi.toInt()}/month (10yr tenure)"),
                      _buildMetricRow("Evaluation Target", "$_selectedCountry | ${_courseController.text}"),
                      const SizedBox(height: 16),
                      Text(
                        res.message,
                        style: AppTextStyles.body(14, color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        
        const SizedBox(height: 32),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          "Matching Partner Lenders",
          style: AppTextStyles.heading(18, color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        
        // Banks Matching List
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: res.matchedLenders.map((offer) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.textMuted.withAlpha(30)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_balance, color: AppColors.secondary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    offer.providerName,
                    style: AppTextStyles.heading(13, color: AppColors.textDark),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "${offer.interestRateMin}% p.a.",
                      style: AppTextStyles.body(11, color: AppColors.accentGreen, weight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Apply for Loan Now",
                onPressed: widget.onApplySuccess,
                icon: Icons.arrow_forward,
                glowEffect: true,
                width: 220,
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: "Recalculate",
                onPressed: () => setState(() => _result = null),
                isSecondary: true,
                width: 160,
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: AppTextStyles.heading(13, color: AppColors.textDark, weight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.body(15, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.body(14, color: AppColors.textMuted),
          prefixIcon: Icon(icon, color: AppColors.textLight, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: AppTextStyles.body(14, color: AppColors.textLight, weight: FontWeight.w600),
          ),
          Text(
            val,
            style: AppTextStyles.heading(14, color: AppColors.textDark, weight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ScoreGaugePainter extends CustomPainter {
  final double score;

  _ScoreGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 10.0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;

    // Background Arc
    final Paint bgPaint = Paint()
      ..color = AppColors.secondary.withAlpha(25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.8,
      math.pi * 1.6,
      false,
      bgPaint,
    );

    // Score Value Arc
    final double sweepAngle = (score / 100) * (math.pi * 1.6);
    final Paint valPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.secondary, AppColors.accentGreen],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.8,
      sweepAngle,
      false,
      valPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score;
  }
}
